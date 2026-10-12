# Verso Templates

This repository contains templates that can be used to get started with Verso. Each template is a
full project that can be copied directly and used a basis for your own writing.

## Getting Started

The quickest way to create a new Verso project is with the setup script. It checks for
prerequisites ([elan](https://github.com/leanprover/elan) and
[git](https://git-scm.com/)), lets you pick a template, and creates a new project with a clean
git history.

### Prerequisites

- [Git](https://git-scm.com/downloads)
- [elan](https://github.com/leanprover/elan#installation) (the Lean version manager)

### Unix (macOS / Linux)

Interactive (prompts you to choose a template):
```
curl -sSfL https://raw.githubusercontent.com/leanprover/verso-templates/main/verso-init.sh | sh
```

Or specify the template and directory directly:
```
curl -sSfL https://raw.githubusercontent.com/leanprover/verso-templates/main/verso-init.sh | sh -s -- textbook my-textbook
```

### Windows

From PowerShell or cmd.exe:
```
powershell -c "irm https://raw.githubusercontent.com/leanprover/verso-templates/main/verso-init.ps1 | iex"
```

Or download and run with arguments:
```
powershell -ExecutionPolicy Bypass -File verso-init.ps1 basic-blog my-blog
```

### Options

- `--list` / `-List`: List available templates
- `--version VERSION` / `-Version VERSION`: Use a specific version (e.g. `v4.28.0`). Defaults to the latest stable release.

### Manually

If you would prefer not to run a script to select a template, then you can download one directly
from the [releases page](https://github.com/leanprover/verso-templates/releases). Each release
provides `.tar.gz` and `.zip` archives for every template, with a fresh Git history already
initialized.

## Browsing the Examples

Each example can be built or modified independently. Additionally, they can all be examined together
by running `./generate.sh`, which builds all the examples, copies their output to a single
directory, and adds an overview page. To build and view all the examples, run:
```
$ ./generate.sh
$ python3 ./serve.py 8000
```
The page is served at `localhost:8000`.


# Book-Like Examples

## Basic Book

This example is a minimal book-like document, showing the smallest way to get started with the
Manual genre. There are no customizations or advanced features used.

## Basic Report

This example is the smallest report-oriented starting point, using the Manual genre with a title,
metadata, and a few simple sections. [Report Features](#report-features) is the fuller report
example, with a detailed structure and coordinated HTML/PDF styling.

## Report Features

This feature-rich template provides a structured report layout with report metadata, an executive summary,
automatically numbered sections, methodology, findings, recommendations, references, and appendices.
It builds both a multi-page website and a PDF (with TeX Live, `latexmk`, XeLaTeX, and its DejaVu
fonts package installed).

## Package Description

This example demonstrates a way to use Verso to describe Lean code.

The code is written in a different version of Lean than the documentation. This decoupling is
important for maintenance: it is possible to adopt a Verso update that requires a newer version of
Lean, even if the example code cannot be yet updated for some reason. Even if both can be updated,
updating first one and then the other can be convenient.
   
Example code is included via special _anchor comments_. Each pair of `-- ANCHOR: XYZ` and
`-- ANCHOR_END: XYZ` defines a named code example `XYZ`. When code is included in the document from
an anchor, it is also included in the document; this makes it easier to read the source code and it
ensures that changes to the code are noticed when they might also require changes in the text.


## Textbook

The textbook example demonstrates how to use a single version of Lean for code examples and the
document's text. In this example, the Lean code blocks elaborate together with the text of the book.

Additionally, this example demonstrates one way to extend the `Manual` genre with new features. It
includes a separate pass for extracting specially-indicated code blocks to their own files, as a
part of building the book. This can be used to create a downloadable archive of the book's example
code, without requiring readers to install or use Verso. This feature is implemented by wrapping the
Lean code block that ships with Verso, so blocks that are to be extracted are indicated as such.
Then, a custom build pass traverses the document, finding all the indicated examples and writing
them to files.

# Web

## Basic Website

This is a small static website generated with Verso's HTML constructors. It includes a home page,
an about page, and provider-neutral instructions for publishing the generated `_site/` directory
to any static host.

## Website Features

The `website-features` template demonstrates a multilingual GVA.DATA website intended for
`https://gva.data.foundation`. It includes English and French routes, nested navigation, blog
articles, project pages, partner tiles, team profiles, a Theory of Change, contact information,
and draft legal pages. A typed content model selects a distinct layout for each section, and
Verso's HTML renderer generates the complete static site. See [website-features/README.md](website-features/README.md)
for build, customization, and deployment instructions.

## Basic Blog

The basic blog example demonstrates the minimal code necessary to get started with using Verso as a static site generator. There are no customizations.

## Blog - Advanced Features

The blog example is a personal website that uses Lean code in blog posts. It demonstrates how to
configure and extend the blog genre, including how to implement a custom theme to control the HTML
generation, a custom HTML component that generates an animated greeter on the front page, and
automatic breadcrumbs.

# Presentations

This example is a minimal [`reveal.js`](https://revealjs.com) slide presentation using
[`verso-slides`](https://github.com/leanprover/verso-slides), with a title slide and a slide that
demonstrates Lean code with an info panel.
