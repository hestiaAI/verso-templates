"""Check the built website without third-party test dependencies."""

from html.parser import HTMLParser
import json
from pathlib import Path
from urllib.parse import urlsplit, unquote
import unittest
import xml.etree.ElementTree as ET


ROOT = Path(__file__).parent / "_site"
ORIGIN = "https://weeknight-table.example.org"


class Page(HTMLParser):
    def __init__(self, path):
        super().__init__()
        self.tags = []
        self.headings = []
        self._heading_tag = None
        self._heading_text = []
        self.feed(path.read_text(encoding="utf-8"))

    def handle_starttag(self, tag, attrs):
        self.tags.append((tag, dict(attrs)))
        if tag in ("h1", "h2", "h3"):
            self._heading_tag = tag
            self._heading_text = []

    def handle_data(self, data):
        if self._heading_tag:
            self._heading_text.append(data)

    def handle_endtag(self, tag):
        if tag == self._heading_tag:
            self.headings.append((tag, " ".join(" ".join(self._heading_text).split())))
            self._heading_tag = None
            self._heading_text = []


class WebsiteTests(unittest.TestCase):
    def test_selected_hosting_output(self):
        provider = json.loads((ROOT / "hosting.json").read_text())["provider"]
        self.assertIn(provider, ("netlify", "vercel", "static"))
        self.assertEqual((ROOT / "_redirects").exists(), provider == "netlify")
        self.assertEqual((ROOT / "_headers").exists(), provider == "netlify")
        self.assertEqual((ROOT / "vercel.json").exists(), provider == "vercel")
        if provider == "netlify":
            self.assertEqual((ROOT / "_redirects").read_text(), "/ /en/ 302!\n")
            self.assertIn("must-revalidate", (ROOT / "_headers").read_text())
        elif provider == "vercel":
            configuration = json.loads((ROOT / "vercel.json").read_text())
            self.assertEqual(configuration["outputDirectory"], ".")
            self.assertEqual(configuration["buildCommand"], "")
            self.assertTrue(configuration["trailingSlash"])
            self.assertEqual(configuration["redirects"], [
                {"source": "/", "destination": "/en/", "permanent": False}])

    def test_every_local_link_and_asset_exists(self):
        pages = list(ROOT.rglob("*.html"))
        self.assertEqual(len(pages), 47, "Run lake exe generate-website first")
        for path in pages:
            parsed = Page(path)
            for tag, attrs in parsed.tags:
                for key in ("href", "src"):
                    url = urlsplit(attrs.get(key, ""))
                    if url.scheme or url.netloc or not url.path:
                        continue
                    target = (path.parent / unquote(url.path)).resolve()
                    self.assertTrue(target.is_relative_to(ROOT.resolve()))
                    if target.is_dir():
                        target = target / "index.html"
                    self.assertTrue(target.is_file(), f"{path}: missing {target}")

    def test_localized_routes_and_metadata(self):
        for language in ("en", "fr"):
            for path in (ROOT / language).rglob("index.html"):
                parsed = Page(path)
                self.assertIn(("html", {"lang": language}), parsed.tags)
                self.assertEqual(sum(tag == "h1" for tag, _ in parsed.tags), 1)
                canonical = [attrs["href"] for tag, attrs in parsed.tags
                             if tag == "link" and attrs.get("rel") == "canonical"]
                expected = ORIGIN + "/" + path.parent.relative_to(ROOT).as_posix() + "/"
                self.assertEqual(canonical, [expected])
                alternates = {attrs["hreflang"] for tag, attrs in parsed.tags
                              if tag == "link" and attrs.get("rel") == "alternate"}
                self.assertEqual(alternates, {"en", "fr"})
                self.assertFalse(any(tag in ("script", "iframe", "form") for tag, _ in parsed.tags))
                other = "fr" if language == "en" else "en"
                self.assertTrue((ROOT / other / path.relative_to(ROOT / language)).is_file())
                footer_links = {attrs.get("href", "") for tag, attrs in parsed.tags if tag == "a"}
                self.assertTrue(any(url.endswith(f"/{language}/terms/") for url in footer_links))
                self.assertTrue(any(url.endswith(f"/{language}/privacy/") for url in footer_links))

    def test_sitemap_and_asset_licenses(self):
        sitemap = ET.parse(ROOT / "sitemap.xml")
        locations = sitemap.findall(".//{http://www.sitemaps.org/schemas/sitemap/0.9}loc")
        self.assertEqual(len(locations), 46)
        for location in locations:
            self.assertTrue(location.text.startswith(ORIGIN + "/"))
            path = ROOT / urlsplit(location.text).path.lstrip("/") / "index.html"
            self.assertTrue(path.is_file())
        self.assertGreater((ROOT / "static/recipes.jpg").stat().st_size, 10000)
        self.assertGreater((ROOT / "static/font.woff2").stat().st_size, 1000)
        self.assertIn("SIL OPEN FONT LICENSE", (ROOT / "static/OFL.txt").read_text())

    def test_recipe_sections_and_featured_listings(self):
        routes = {
            "recipes": ("tomato-chickpea-traybake", "green-lentil-soup", "apple-oat-pancakes"),
            "tools": ("appliances/foodmate", "appliances/mixmate", "apps/label-lens", "apps/calorie-optics"),
            "supermarkets": ("freshmart", "dailymarket"),
            "meal-plans": ("five-easy-evenings", "use-it-up"),
            "kitchen-basics": ("swap-with-confidence", "read-the-label", "store-leftovers"),
        }
        for language in ("en", "fr"):
            for section, slugs in routes.items():
                landing = Page(ROOT / language / section / "index.html")
                links = {attrs.get("href", "") for tag, attrs in landing.tags if tag == "a"}
                for slug in slugs:
                    self.assertTrue(any(url.endswith(f"/{language}/{section}/{slug}/") for url in links))
                    self.assertTrue((ROOT / language / section / slug / "index.html").is_file())
            home_page = Page(ROOT / language / "index.html")
            home_html = (ROOT / language / "index.html").read_text(encoding="utf-8")
            self.assertIn("Weeknight Table", home_html)
            labels = ("Recipes", "Tools", "Supermarkets", "Meal Plans", "Kitchen Basics") if language == "en" else (
                "Recettes", "Outils", "Supermarchés", "Menus de la semaine", "Bases en cuisine")
            for label in labels:
                self.assertIn(label, home_html)
            self.assertIn("/recipes/tomato-chickpea-traybake/", home_html)
            self.assertTrue((ROOT / language / "tools/appliances/mixmate/index.html").is_file())
            self.assertTrue((ROOT / language / "tools/apps/label-lens/index.html").is_file())
            self.assertTrue((ROOT / language / "supermarkets/freshmart/index.html").is_file())
            self.assertTrue((ROOT / language / "supermarkets/dailymarket/index.html").is_file())
            self.assertNotIn("GVA.DATA", home_html)
            tools_page = Page(ROOT / language / "tools/index.html")
            menu_labels = ("Appliances", "Apps") if language == "en" else ("Appareils", "Applications")
            for label in menu_labels:
                self.assertIn(("h3", label), home_page.headings)
                self.assertIn(("h2", label), tools_page.headings)


if __name__ == "__main__":
    unittest.main()