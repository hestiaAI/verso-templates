# Basic Verso Website

A small static website generated with Verso's HTML constructors. Edit `Main.lean` for page
content and routes, and `static_files/style.css` for styling.

Build and preview locally:

```sh
lake build
lake exe generate-website
python3 -m http.server 8000 --directory _site
```

Open http://localhost:8000/. The generated site is the contents of `_site/`.

## Deployment

Build the project, then publish the contents of `_site/` to any static file host. The host's
document root should point at that directory and serve `index.html` for `/` and
`about/index.html` for `/about/`. For a Git-based host build, configure the build command as
`lake exe generate-website` and the publish/output directory as `_site`; install Lean and
resolve the Lake dependencies in the build environment first. No provider-specific settings,
domain, or DNS configuration are required by this template.