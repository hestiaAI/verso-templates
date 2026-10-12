# Weeknight Table

A bilingual recipe website built with Lean and Verso's structured HTML renderer. The sample
focuses on practical home cooking, flexible meal plans, and straightforward notes about kitchen
tools and local supermarkets. MixMate, LabelLens, FreshMart and DailyMarket are listed for illustration;
their inclusion does not imply an endorsement, sponsorship or affiliation.

## Build and Preview

Requires elan/Lean and the usual Lake build prerequisites. Python 3.9 or later is needed for
the included checks and optional local preview. Run these commands from this directory:

```sh
lake build
lake exe generate-website
python3 check_site.py
python3 -m http.server 8002 --bind 127.0.0.1 --directory _site
```

Open http://localhost:8002/en/ or http://localhost:8002/fr/. The root URL redirects to
English and offers a French link as a fallback. Generated pages do not require JavaScript.

## Sections

| Section | Contents |
| --- | --- |
| Recipes | Everyday dishes with timings, servings and adaptable instructions |
| Tools | Appliances: FoodMate and MixMate. Apps: LabelLens and CalorieOptics, under matching nested routes. |
| Supermarkets | FreshMart and DailyMarket shopping notes; no live prices or stock claims |
| Meal Plans | Flexible weeknight and low-waste meal outlines |
| Kitchen Basics | Ingredient swaps, label reading and leftover safety |

Edit [Content.lean](Content.lean) to change sections and entries. Each entry has English and
French fields for its title, category, summary, body and metadata. Stable slugs keep routes
aligned between languages. Edit [Main.lean](Main.lean) for site-wide navigation, homepage,
metadata, legal pages or rendering rules. Edit [static_files/style.css](static_files/style.css)
for styling. The recipes are examples, not medical or nutrition advice; check product labels,
allergens and current food-safety guidance.

The generator's canonical origin is the reserved example domain
`https://weeknight-table.example.org`. Change `siteOrigin` in `Main.lean` before publishing
to a real domain. Hosting configuration is provided for Netlify and Vercel; set the provider
in [hosting.json](hosting.json) and publish the generated `_site` directory. For a repository
containing the full templates collection, use `website-features` as the host's base directory.

## Assets and Limitations

The hero photograph is served locally and used under the [Unsplash License](https://unsplash.com/license).
Space Grotesk is distributed under the SIL Open Font License included at
[static_files/OFL.txt](static_files/OFL.txt). The site has no analytics, forms, cookies or
embedded third-party services. Product availability, ranges and prices are not fetched live.

Contact and legal pages are demonstration text. Review them, verify image and font terms,
replace the example domain and content, and provide confirmed contact details before launch.