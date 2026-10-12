import Verso.Output.Html

open Verso.Output

def text (value : String) : Html := .text true value

def node (name : String) (children : Array Html) (attrs : Array (String × String) := #[]) : Html :=
  .tag name attrs (.seq children)

def link (href label : String) : Html :=
  node "a" #[text label] #[("href", href)]

def page : Html :=
  node "html" #[
    node "head" #[
      node "meta" #[] #[("charset", "utf-8")],
      node "meta" #[] #[("name", "viewport"), ("content", "width=device-width, initial-scale=1")],
      node "title" #[text "My Website"],
      node "link" #[] #[("rel", "stylesheet"), ("href", "style.css")]
    ],
    node "body" #[
      node "header" #[node "a" #[text "My Website"] #[("href", "./"), ("class", "brand")],
        node "nav" #[link "./" "Home", link "about/" "About"]],
      node "main" #[
        node "p" #[text "A Verso website"] #[("class", "eyebrow")],
        node "h1" #[text "A place for your ideas"],
        node "p" #[text "Replace this page with your own content."],
        link "about/" "About this site"
      ],
      node "footer" #[text "Built with Lean and Verso."]
    ]
  ] #[("lang", "en")]

def main : IO Unit := do
  IO.FS.createDirAll "_site"
  IO.FS.writeFile "_site/index.html" ("<!doctype html>\n" ++ page.asString)
  IO.FS.writeFile "_site/style.css" (← IO.FS.readFile "static_files/style.css")
  IO.FS.createDirAll "_site/about"
  let about := node "html" #[
    node "head" #[
      node "meta" #[] #[("charset", "utf-8")],
      node "meta" #[] #[("name", "viewport"), ("content", "width=device-width, initial-scale=1")],
      node "title" #[text "About | My Website"],
      node "link" #[] #[("rel", "stylesheet"), ("href", "../style.css")]
    ],
    node "body" #[
      node "header" #[node "a" #[text "My Website"] #[("href", "../"), ("class", "brand")],
        node "nav" #[link "../" "Home", link "./" "About"]],
      node "main" #[node "p" #[text "About"] #[("class", "eyebrow")],
        node "h1" #[text "About this site"],
        node "p" #[text "Add a short introduction to your project here."],
        link "../" "Back home"],
      node "footer" #[text "Built with Lean and Verso."]
    ]
  ] #[("lang", "en")]
  IO.FS.writeFile "_site/about/index.html" ("<!doctype html>\n" ++ about.asString)
  IO.println "Generated website in _site/."