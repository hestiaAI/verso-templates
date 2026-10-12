import Verso.Output.Html
import Content

open Verso.Output

def text (value : String) : Html := .text true value
def node (name : String) (children : Array Html) (attrs : Array (String × String) := #[]) : Html :=
  .tag name attrs (.seq children)
def tr (language english french : String) : String :=
  (Translation.mk english french).get language
def link (href label : String) (attrs : Array (String × String) := #[]) : Html :=
  node "a" #[text label] (#[ ("href", href) ] ++ attrs)
def paragraph (value : String) : Html := node "p" #[text value]
def siteOrigin := "https://weeknight-table.example.org"

def rootPath (slug : String) : String :=
  let depth := if slug.isEmpty then 1 else (slug.splitOn "/").length + 1
  String.join (List.replicate depth "../")
def route (root language slug : String) := root ++ language ++ "/" ++ (if slug.isEmpty then "" else slug ++ "/")
def toolGroupMenu (language root : String) (category : Section) (group : Translation) : Html :=
  node "section" #[
    node "h3" #[text (group.get language)] #[("class", "submenu-heading")],
    node "div" ((category.items.filter (fun item => item.group.en == group.en)).map fun item =>
      link (route root language (category.slug ++ "/" ++ item.slug)) (item.title.get language)) #[("class", "submenu-links")]
  ] #[("class", "submenu-group")]

def pageTitle (language slug : String) : String := Id.run do
  if slug.isEmpty then return "Weeknight Table"
  for category in sections do
    if slug == category.slug then return category.title.get language
    for item in category.items do
      if slug == category.slug ++ "/" ++ item.slug then return item.title.get language
  return match slug with
    | "contact" => tr language "Contact" "Contact"
    | "terms" => tr language "Terms of Use" "Conditions d'utilisation"
    | "privacy" => tr language "Privacy policy" "Politique de confidentialité"
    | _ => "Weeknight Table"

def navigation (language slug root : String) : Html :=
  node "header" #[
    link (route root language "") "Weeknight Table" #[("class", "brand"), ("aria-label", tr language "Weeknight Table home" "Accueil Weeknight Table")],
    node "nav" ((sections.map fun category =>
      node "div" #[
        link (route root language category.slug) (category.title.get language)
          #[("aria-current", if (slug.splitOn "/").head! == category.slug then "page" else "false")],
        node "details" #[
          node "summary" #[text "⌄"] #[("aria-label", tr language ("Explore " ++ category.title.en) ("Explorer " ++ category.title.fr))],
          (if category.slug == "tools" then
            node "div" #[
              toolGroupMenu language root category ⟨"Appliances", "Appareils"⟩,
              toolGroupMenu language root category ⟨"Apps", "Applications"⟩
            ] #[("class", "submenu grouped-submenu")]
          else
            node "div" (category.items.map fun item => link (route root language (category.slug ++ "/" ++ item.slug)) (item.title.get language)) #[("class", "submenu")])
        ] #[("class", "dropdown"), ("name", "navigation-submenus")]
      ] #[("class", "nav-category")]).push
      (link (route root language "contact") (tr language "Contact" "Contact") #[("aria-current", if slug == "contact" then "page" else "false")]))
      #[("aria-label", tr language "Main navigation" "Navigation principale")],
    node "div" #[
      link (route root "en" slug) "EN" #[("lang", "en"), ("hreflang", "en"), ("aria-current", if language == "en" then "true" else "false")],
      link (route root "fr" slug) "FR" #[("lang", "fr"), ("hreflang", "fr"), ("aria-current", if language == "fr" then "true" else "false")]
    ] #[("class", "languages"), ("role", "group"), ("aria-label", tr language "Language" "Langue")]
  ] #[("class", "site-header")]

def footer (language root : String) : Html :=
  node "footer" #[
    node "div" #[text "Weeknight Table", paragraph (tr language "Good food, less fuss." "De bons repas, sans complication.")] #[("class", "footer-brand")],
    node "div" #[
      link (route root language "terms") (tr language "Terms of Use" "Conditions d'utilisation"),
      link (route root language "privacy") (tr language "Privacy policy" "Politique de confidentialité"),
      paragraph (tr language "Recipes and retailer notes are examples; product details can change and no brand affiliation is implied." "Les recettes et informations sur les enseignes sont des exemples ; les produits peuvent changer et aucune affiliation n'est suggérée.")
    ],
    node "small" #[text (tr language "Food photograph: " "Photo culinaire : "),
      link "https://unsplash.com/license" "Unsplash License"]
  ] #[("class", "site-footer")]

def itemCard (language root : String) (category : Section) (item : Item) : Html :=
  node "article" #[
    if category.layout == .partners || category.layout == .people then
      node "div" #[text item.initials] #[("class", if category.layout == .partners then "partner-mark" else "person-mark"), ("aria-hidden", "true")]
    else node "p" #[text (item.category.get language)] #[("class", "eyebrow")],
    node "h2" #[link (route root language (category.slug ++ "/" ++ item.slug)) (item.title.get language)],
    if category.layout == .partners || category.layout == .people then paragraph (item.category.get language) else .empty,
    paragraph (item.summary.get language),
    node "p" #[text (item.metadata.get language)] #[("class", "meta")],
    link (route root language (category.slug ++ "/" ++ item.slug))
      (tr language "Explore →" "Découvrir →") #[("class", "text-link"), ("aria-label", tr language ("Explore " ++ item.title.en) ("Découvrir " ++ item.title.fr))]
  ] #[("class", "item")]

def layoutName : Layout → String
  | .posts => "post-list"
  | .projects => "project-grid"
  | .partners => "partner-grid"
  | .people => "people-grid"
  | .theory => "theory-grid"

def toolGroupPage (language root : String) (category : Section) (group : Translation) : Html :=
  node "section" #[
    node "h2" #[text (group.get language)] #[("class", "tool-group-title")],
    node "div" ((category.items.filter (fun item => item.group.en == group.en)).map (itemCard language root category)) #[("class", "project-grid")]
  ] #[("class", "tool-group")]

def sectionPage (language root : String) (category : Section) : Html :=
  node "div" #[
    node "div" #[node "p" #[text "Weeknight Table / ", text (category.title.get language)] #[("class", "eyebrow")],
      node "h1" #[text (category.title.get language)],
      paragraph (category.intro.get language)] #[("class", "page-heading")],
    if category.slug == "tools" then
      node "div" #[
        toolGroupPage language root category ⟨"Appliances", "Appareils"⟩,
        toolGroupPage language root category ⟨"Apps", "Applications"⟩
      ] #[("class", "tools-groups")]
    else node "div" (category.items.map (itemCard language root category)) #[("class", layoutName category.layout)]
  ] #[("class", "page-shell")]

def detailPage (language root : String) (category : Section) (item : Item) : Html :=
  node "article" #[
    node "nav" #[link (route root language "") "Weeknight Table", text " / ",
      link (route root language category.slug) (category.title.get language)] #[("class", "breadcrumbs"), ("aria-label", tr language "Breadcrumbs" "Fil d'Ariane")],
    node "p" #[text (item.category.get language)] #[("class", "eyebrow")],
    node "h1" #[text (item.title.get language)],
    node "p" #[text (item.metadata.get language)] #[("class", "meta")],
    node "p" #[text (item.summary.get language)] #[("class", "lead")],
    paragraph (item.body.get language),
    node "aside" #[node "h2" #[text (tr language "Keep exploring" "Poursuivre la découverte")],
      link (route root language category.slug) (tr language ("All " ++ category.title.en) ("Voir : " ++ category.title.fr)),
      link (route root language "contact") (tr language "Get in touch →" "Nous contacter →")]
      #[("class", "related")]
  ] #[("class", "detail-page " ++ layoutName category.layout)]

def homePage (language root : String) : Html :=
  node "div" #[
    node "section" #[
      node "img" #[] #[("src", root ++ "static/recipes.jpg"), ("alt", tr language "A colourful bowl of fresh vegetables and grains" "Un bol coloré de légumes frais et de céréales"), ("class", "hero-photo"), ("fetchpriority", "high"), ("width", "2000"), ("height", "1333")],
      node "div" #[node "p" #[text (tr language "A practical recipe notebook · Geneva" "Un carnet de recettes pratiques · Genève")] #[("class", "eyebrow")],
        node "h1" #[text "Weeknight Table"],
        paragraph (tr language "Good food, a workable plan, and less waste." "De bons repas, un menu réaliste et moins de gaspillage."),
        link (route root language "recipes") (tr language "Find a recipe →" "Trouver une recette →") #[("class", "hero-link")]
      ] #[("class", "hero-copy")]
    ] #[("class", "hero")],
    node "section" #[
      node "div" #[node "p" #[text (tr language "Start with what is in the kitchen" "Commencer par ce qu'il y a dans la cuisine")] #[("class", "eyebrow")],
        node "h2" #[text (tr language "Cook what you have. Make room for something good." "Cuisinez ce que vous avez. Faites place à quelque chose de bon.")]],
      node "div" #[paragraph (tr language "Weeknight Table is an illustrative recipe notebook for flexible home cooking. Find everyday recipes, a few notes on kitchen tools and supermarkets, and meal plans that leave room for substitutions and leftovers." "Weeknight Table est un carnet de recettes illustratif pour une cuisine familiale flexible. Découvrez des recettes du quotidien, des repères sur les ustensiles et supermarchés, et des menus qui laissent place aux substitutions et aux restes."),
        link (route root language "meal-plans") (tr language "Browse the meal plans →" "Voir les menus →") #[("class", "text-link")]]
    ] #[("class", "introduction page-shell")],
    node "section" #[
      node "div" #[node "h2" #[text (tr language "Kitchen companions" "Les compagnons de cuisine")],
        link (route root language "tools") (tr language "All tools →" "Tous les outils →") ] #[("class", "category-heading")],
      node "div" ((sections[1]!).items.map (itemCard language root sections[1]!)) #[("class", "project-grid")]
    ] #[("class", "work-band")],
    node "section" #[node "div" #[node "h2" #[text (tr language "From the recipe book" "Du carnet de recettes")],
      link (route root language "recipes") (tr language "All recipes →" "Toutes les recettes →")] #[("class", "category-heading")],
      node "div" ((sections[0]!).items.map (itemCard language root sections[0]!)) #[("class", "post-list")]
    ] #[("class", "page-shell home-recipes")]
  ]

def simplePage (language slug : String) : Html :=
  let title := pageTitle language slug
  let content := match slug with
    | "contact" => #[
        paragraph (tr language "Questions about a recipe, an ingredient swap or this example site?" "Une question sur une recette, un ingrédient de remplacement ou ce site d'exemple ?"),
        node "h2" #[text (tr language "About this notebook" "À propos de ce carnet")],
        paragraph (tr language "This is a sample recipe website, not a food, nutrition or retail service. It has no active contact inbox or form." "Ce site de recettes est un exemple, pas un service alimentaire, nutritionnel ou commercial. Il ne dispose d'aucune messagerie ni d'aucun formulaire actif."),
        paragraph (tr language "For allergies or medical dietary needs, check product packaging and consult a qualified professional." "En cas d'allergie ou de besoin alimentaire médical, vérifiez les emballages et consultez un professionnel qualifié.")]
    | "terms" => #[
        paragraph (tr language "Draft for demonstration · Not legal advice · Updated 10 October 2026" "Projet de démonstration · Ne constitue pas un avis juridique · Mis à jour le 10 octobre 2026"),
        node "h2" #[text (tr language "About this website" "À propos de ce site")],
        paragraph (tr language "Weeknight Table is an illustrative recipe website, not an operational food or nutrition service. Recipes and retailer notes are examples, and product availability can change. Content is provided without a guarantee of completeness or accuracy." "Weeknight Table est un site de recettes illustratif, et non un service alimentaire ou nutritionnel opérationnel. Les recettes et informations sur les enseignes sont des exemples ; les produits disponibles peuvent changer. L'exhaustivité et l'exactitude des contenus ne sont pas garanties."),
        node "h2" #[text (tr language "Reuse and third-party content" "Réutilisation et contenus tiers")],
        paragraph (tr language "The locally served food photograph is from Unsplash and is used under the Unsplash License, linked in the footer. Product names belong to their respective owners; no sponsorship or affiliation is implied." "La photographie culinaire servie localement provient d'Unsplash et est utilisée selon la licence Unsplash, indiquée en pied de page. Les noms de produits appartiennent à leurs propriétaires respectifs ; aucune affiliation ni commandite n'est suggérée."),
        paragraph (tr language "Before launch, the operator must supply its legal identity, contact details, applicable jurisdiction and reviewed terms." "Avant publication, le responsable doit fournir son identité juridique, ses coordonnées, la juridiction applicable et des conditions validées.")]
    | _ => #[
        paragraph (tr language "Draft for demonstration · Updated 10 October 2026" "Projet de démonstration · Mis à jour le 10 octobre 2026"),
        node "h2" #[text (tr language "A minimal static website" "Un site statique minimal")],
        paragraph (tr language "The generated website sets no cookies, uses no analytics, and stores no visitor information in the browser. Fonts, styles and the photograph are served locally. There are no embedded third-party services or data-collection forms." "Le site généré ne dépose aucun cookie, n'utilise aucun outil d'analyse et ne stocke aucune information dans le navigateur. Polices, styles et photographie sont servis localement. Aucun service tiers ni formulaire de collecte n'est intégré."),
        node "h2" #[text (tr language "Hosting and external links" "Hébergement et liens externes")],
        paragraph (tr language "A hosting provider may process IP addresses, request paths and timestamps in server logs. Its retention, location and security practices must be documented by the operator before launch. Following external links takes you to services with their own privacy policies." "Un hébergeur peut traiter les adresses IP, les chemins demandés et les horodatages dans ses journaux. Le responsable doit documenter leur conservation, leur localisation et leur sécurité avant publication. Les liens externes conduisent à des services ayant leurs propres politiques."),
        paragraph (tr language "The data controller and privacy contact have not been configured for this demonstration. A production privacy notice must identify them and explain how to exercise applicable rights." "Le responsable du traitement et le contact relatif à la vie privée ne sont pas configurés dans cette démonstration. Une politique de production doit les identifier et expliquer comment exercer les droits applicables.")]
  node "article" (#[node "h1" #[text title]] ++ content) #[("class", "detail-page")]

def page (language slug : String) (content : Html) : Html :=
  let root := rootPath slug
  let url := siteOrigin ++ "/" ++ language ++ "/" ++ (if slug.isEmpty then "" else slug ++ "/")
  node "html" #[
    node "head" #[node "meta" #[] #[("charset", "utf-8")],
      node "meta" #[] #[("name", "viewport"), ("content", "width=device-width, initial-scale=1")],
      node "title" #[text (pageTitle language slug ++ (if slug.isEmpty then "" else " | Weeknight Table"))],
      node "meta" #[] #[("name", "description"), ("content", tr language "Flexible recipes, practical meal plans and clear notes on kitchen tools." "Des recettes flexibles, des menus pratiques et des repères clairs sur les outils de cuisine.")],
      node "link" #[] #[("rel", "stylesheet"), ("href", root ++ "static/style.css")],
      node "link" #[] #[("rel", "canonical"), ("href", url)],
      node "link" #[] #[("rel", "alternate"), ("hreflang", "en"), ("href", siteOrigin ++ "/en/" ++ (if slug.isEmpty then "" else slug ++ "/"))],
      node "link" #[] #[("rel", "alternate"), ("hreflang", "fr"), ("href", siteOrigin ++ "/fr/" ++ (if slug.isEmpty then "" else slug ++ "/"))]
    ],
    node "body" #[link "#main" (tr language "Skip to content" "Aller au contenu") #[("class", "skip-link")],
      navigation language slug root, node "main" #[content] #[("id", "main")], footer language root]
  ] #[("lang", language)]

def writePage (language slug : String) (content : Html) : IO Unit := do
  let directory : System.FilePath := "_site" / language / slug
  IO.FS.createDirAll directory
  IO.FS.writeFile (directory / "index.html") ("<!doctype html>\n" ++ (page language slug content).asString)

def hostingProvider (args : List String) : IO String := do
  let provider ← match args with
    | [] => do
      let configuration ← IO.FS.readFile "hosting.json"
      let json ← IO.ofExcept (Lean.Json.parse configuration)
      IO.ofExcept (json.getObjValAs? String "provider")
    | ["--hosting", provider] => pure provider
    | _ => throw (IO.userError "Usage: generate-website [--hosting netlify|vercel|static]")
  if !#["netlify", "vercel", "static"].contains provider then
    throw (IO.userError s!"Unknown hosting provider '{provider}'. Choose netlify, vercel or static.")
  return provider

def writeHosting (provider : String) : IO Unit := do
  for name in #["_redirects", "_headers", "vercel.json"] do
    let path : System.FilePath := "_site" / name
    if ← path.pathExists then IO.FS.removeFile path
  if provider == "netlify" then
    IO.FS.writeFile "_site/_redirects" "/ /en/ 302!\n"
    IO.FS.writeFile "_site/_headers" "/*\n  X-Content-Type-Options: nosniff\n  Referrer-Policy: strict-origin-when-cross-origin\n  Cache-Control: public, max-age=0, must-revalidate\n"
  else if provider == "vercel" then
    let configuration := Lean.Json.mkObj [
      ("$schema", .str "https://openapi.vercel.sh/vercel.json"),
      ("framework", .null), ("buildCommand", .str ""), ("installCommand", .str ""),
      ("outputDirectory", .str "."), ("trailingSlash", .bool true),
      ("redirects", .arr #[Lean.Json.mkObj [
        ("source", .str "/"), ("destination", .str "/en/"), ("permanent", .bool false)]]),
      ("headers", .arr #[Lean.Json.mkObj [
        ("source", .str "/(.*)"),
        ("headers", .arr (#[
          ("X-Content-Type-Options", "nosniff"),
          ("Referrer-Policy", "strict-origin-when-cross-origin"),
          ("Cache-Control", "public, max-age=0, must-revalidate")].map fun (key, value) =>
            Lean.Json.mkObj [("key", .str key), ("value", .str value)]))]])]
    IO.FS.writeFile "_site/vercel.json" (configuration.pretty ++ "\n")
  IO.FS.writeFile "_site/hosting.json" ((Lean.Json.mkObj [("provider", .str provider)]).pretty ++ "\n")

def main (args : List String) : IO Unit := do
  let provider ← hostingProvider args
  if ← System.FilePath.pathExists "_site" then
    IO.FS.removeDirAll "_site"
  for language in #["en", "fr"] do
    writePage language "" (homePage language (rootPath ""))
    for category in sections do
      writePage language category.slug (sectionPage language (rootPath category.slug) category)
      for item in category.items do
        let slug := category.slug ++ "/" ++ item.slug
        writePage language slug (detailPage language (rootPath slug) category item)
    for slug in #["contact", "terms", "privacy"] do
      writePage language slug (simplePage language slug)
  IO.FS.createDirAll "_site/static"
  for name in #["style.css", "recipes.jpg", "font.woff2", "OFL.txt"] do
    IO.FS.writeBinFile ("_site/static/" ++ name) (← IO.FS.readBinFile ("static_files/" ++ name))
  let entry := node "html" #[node "head" #[node "meta" #[] #[("charset", "utf-8")],
    node "meta" #[] #[("http-equiv", "refresh"), ("content", "0;url=en/")], node "title" #[text "Weeknight Table"]],
    node "body" #[link "en/" "English", text " · ", link "fr/" "Français"]] #[("lang", "en")]
  IO.FS.writeFile "_site/index.html" ("<!doctype html>\n" ++ entry.asString)
  let urls := #["en", "fr"] |>.flatMap fun language =>
    let slugs := #["", "contact", "terms", "privacy"] ++ sections.flatMap (fun category =>
      #[category.slug] ++ category.items.map (fun item => category.slug ++ "/" ++ item.slug))
    slugs.map fun slug => node "url" #[node "loc" #[text (siteOrigin ++ "/" ++ language ++ "/" ++ (if slug.isEmpty then "" else slug ++ "/"))]]
  IO.FS.writeFile "_site/sitemap.xml" ("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" ++
    (node "urlset" urls #[("xmlns", "http://www.sitemaps.org/schemas/sitemap/0.9")]).asString)
  IO.FS.writeFile "_site/robots.txt" ("User-agent: *\nAllow: /\nSitemap: " ++ siteOrigin ++ "/sitemap.xml\n")
  writeHosting provider
  IO.println s!"Generated Weeknight Table in _site/ (English and French; hosting: {provider})."