+++
title = "A Fresh Coat Of Paint"
description = "Migrating to Zola"
author = "Ian Andwati"
date = 2023-08-24
[taxonomies]
tags = ["zola", "blog", "tera", "rust"]
+++

Using Zola as my preferred static site generator

<!-- more -->

After using Hugo for over eight months I got tired of it and looked for other alternatives. That's when I stumbled upon Zola. Zola is a static site generator (SSG), similar to [Hugo](https://gohugo.io/), [Pelican](https://blog.getpelican.com/), and [Jekyll](https://jekyllrb.com/).

It is written in Rust and uses the Tera template engine, similar to Jinja2, Django templates, Liquid, and Twig. SSGs use dynamic templates to transform content into static HTML pages. Static sites are thus very fast and require no databases, making them easy to host.

My previous Hugo site used a theme because I wasn't really ready to learn Go's template engine. I'm already familiar with Python Django and its template system so using Tera wasn't hard because it's similar to jinja2 and the Django template syntax.

Content is written in [CommonMark](https://commonmark.org/), a strongly defined, highly compatible specification of [Markdown](https://www.markdownguide.org/). Zola uses [pulldown-cmark](https://github.com/raphlinus/pulldown-cmark#pulldown-cmark) to parse markdown files. The goal of this library is 100% compliance with the CommonMark spec. It adds a few additional features such as parsing footnotes, Github-flavored tables, Github-flavored task lists, and strikethrough.

Zola comes with built-in syntax highlighting, but you must first enable it in the configuration file.

Zola is very minimalistic, it is installed only as a single binary, with no extra dependencies needed. It is configured in `toml` and you only use what is needed. For example here is the configuration for this site `config.toml`:

```toml
title = "Ian Andwati"
description = "Ian Andwati's personal website"
base_url = "https://andwati.com"

generate_categories_pages = false
generate_tags_pages = false
generate_feed = true
feed_filename = "rss.xml"
minify_html = false
taxonomies = [{ name = 'tags', feed = false }]
compile_sass = true

[markdown]
highlight_code = true
highlight_theme = "gruvbox-dark"

[link_checker]

[extra]
author = "Ian Andwati"
```

## Inspiration

The motivation to use Zola also came from my decision to move from independently developed themes. I decided to write the html and css myself and endeavor to maintain the site individually. The base CSS is borrowed from [Reilly Tucker Siemens](https://tuckersiemens.com/) who had created a nice gruvbox palette for his site.

I improved on it by adding an archive page, pagination, a comment system, and google analytics(more of these in later posts). I also implemented article read time and word count.

## What next

The site is a working progress and is far from polished. I plan on implementing a newsletter to notify readers of new posts. The site is primarily a dark theme, in the future I'll also add theme toggling and maybe different palettes.

You can subscribe to the site's RSS feed at [https://andwati.com/rss.xml](https://andwati.com/rss.xml).