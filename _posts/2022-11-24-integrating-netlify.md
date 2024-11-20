---
title : Integrating Netlify CMS
description : Integrating netlify cms
date : 2022-11-24
tags :  [blog, hugo, netlify,netlify-cms,github]
---

Migrating to a better content management system through Netlify CMS

<!-- more -->

# Heavy Lifting

I use [Visual Studio Code](https://code.visualstudio.com/) to manually edit the blog post content on this website. This is quite a hassle because I have to deal with
markdown files. There are many problems with this approach and several gotchas. I have to work on a local site repository to be able to edit the content. My GitHub credentials are also required to push my local changes to my remote repository on GitHub so that it can trigger the build process and publish the site.

This process has helped me a lot to master markdown syntax and some practice on my git skills. It’s fun to update the website content following these steps but sometimes it can be frustrating. At those times, I really miss the user interface of content management systems. After careful consideration, I moved on with Netlify CMS. At its core, Netlify CMS is an open-source React app that acts as a wrapper for the Git workflow, using the GitHub, GitLab, or Bitbucket API. This provides many advantages, including:

- **Fast, web-based UI:** With rich-text editing, real-time preview, and drag-and-drop media uploads.
- **Platform agnostic:** Works with most static site generators.
- **Easy installation:** Add two files to your site and hook up the backend by including those files in your build process or linking to our Content Delivery Network (CDN).
- **Modern authentication:** Using GitHub, GitLab, or Bitbucket and JSON web tokens.
- **Flexible content types:** Specify an unlimited number of content types with custom fields.
- **Fully extensible:** Create custom-styled previews, UI widgets, and editor plugins.

# Redeploying to Netlify

I decided to move the site from GitHub pages to Netlify hosting to take full control of the platform. Hugo sites on Netlify can benefit from automatic framework detection and control over Hugo version selection. When you link a repository for a project, Netlify tries to detect the framework your site is using. If your site is built with Hugo, Netlify provides a suggested build command and publish directory: Hugo and public. The build process is straight forward but you can add custom options to your `netlify.toml` file, here are my options:

```toml
[build]
command = "hugo"
publish = "public"

[build.environment]
HUGO_VERSION = "0.105.0"
```

# Setting up Netlify CMS

You can adapt Netlify CMS to a wide variety of projects. It works with any content written in markdown, JSON, YAML, or TOML files, stored in a repo on GitHub, GitLab, or Bitbucket. You can Netlify CMS to a site that's built with a common static site generator, like Jekyll, Hugo, Hexo, or Gatsby. The official documentation for installing on your website can be found at the [official site](https://www.netlifycms.org/docs/intro/)

## Steps

**Step 1**

Create a static admin folder containing all Netlify CMS files, stored at the root of your published site. Where you store this folder in the source files depends on your static site generator. For Hugo, it is the `static` folder.

`/static/admin`

**Step 2**

Inside the admin folder, create two files: `index.html` and `config.yml`. The first file `admin/index.html` is an entry point to Netlify CMS. You will access the CMS interface from `yourwebsite.com/admin` when everything is ready.

**Step 3**

The first file, `admin/index.html`, is the entry point for the Netlify CMS admin interface. Paste this code in index.html and save. This HTML starter page will load the Netlify CMS Javascript file:

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Content Manager</title>
  </head>
  <body>
    <!-- Include the script that builds the page and powers Netlify CMS -->
    <script src="https://unpkg.com/netlify-cms@^2.0.0/dist/netlify-cms.js"></script>
  </body>
</html>
```

**Step 4**

Now let’s move to the configuration section. These are the configurations that go into the `config.yml` file. This process is different for every site. I followed the guidelines on the website and made minor adjustments. It worked on my website. The configuration options are available at the [docs](<https://www.netlifycms.org/docs/add-to-your-site/#:~:text=%2C%20MyTemplate)-,Configuration,-Configuration%20is%20different>). This is how I configured my config.yml file:

```yaml
backend:
  name: git-gateway
  branch: netlify-cms # Branch to update (optional; defaults to master)

# This line should *not* be indented
publish_mode: editorial_workflow

media_folder: "static/images/uploads" # Media files will be stored in the repo under static/images/uploads
public_folder: "/images/uploads" # The src attribute for uploaded media will begin with /images/uploads

collections:
  - name: "post" # Used in routes, e.g., /admin/collections/blog
    label: "posts" # Used in the UI
    folder: "content/post" # The path to the folder where the documents are stored
    create: true # Allow users to create new documents in this collection
    slug: "{{year}}-{{month}}-{{day}}-{{slug}}" # Filename template, e.g., YYYY-MM-DD-title.md
    fields: # The fields for each document, usually in front matter
      - { label: "Layout", name: "layout", widget: "hidden", default: "blog" }
      - { label: "Title", name: "title", widget: "string" }
      - { label: "Draft", name: "draft", widget: "boolean", default: true }
      - { label: "Publish Date", name: "date", widget: "datetime" }
      - { label: "Last Modified", name: "lastmod", widget: "datetime" }
      - { label: "Body", name: "body", widget: "markdown" }
      - { label: "Keywords", name: "keywords", widget: "list" }
      - { label: "Tags", name: "tags", widget: "list" }
      - { label: "Categories", name: "categories", widget: "list" }
      - { label: "Comments", name: "comment", widget: "boolean", default: true }
      - {
          label: "Table of Contents",
          name: "toc",
          widget: "boolean",
          default: true,
        }
```

**Step 5**

**Authentication**

Now that the Netlify CMS files are in place and configured, all that's left is to enable authentication.
Netlify offers a built-in authentication service called Identity. In order to use it, connect your site repo with Netlify. Netlify has published a general [Step-by-Step Guide](https://www.netlify.com/blog/2016/10/27/a-step-by-step-guide-deploying-a-static-site-or-single-page-app/) for this, along with detailed guides for many popular static site generators

Let’s first enable Netlify Identity and Git Gateway:

- On your Netlify account, go to **Settings > Identity** and select **Enable Identity Service**
- Under **Registration preferences**, select **Invite Only**.
- If you want to enable login from external providers such as Google and GitHub, check the boxes you want to use, under **External Providers** section. I find it practical to log in with GitHub, so I added it.
- Go to **Services > Git Gateway**, and click **Enable Git Gateway**. This authenticates with your Git Host and generates and API token.
- Everything is almost set up. What we need now is a front-end interface to connect. We will add the following script in two places, to include the **Netlify Identity Widget** on our website:

```html
<script src="https://identity.netlify.com/v1/netlify-identity-widget.js"></script>
```

We will use Netlify's [script injection](https://docs.netlify.com/site-deploys/post-processing/snippet-injection/) feature to add the script to our site. To use snippet injection, go to **Site Settings > Build & Deploy > Post processing**. Find the Snippet Injection section and select **Add Snippet**. Write a name for the script in the first box (e.g. Netlify Identity Widget). Paste the script inside the second box. Choose Insert before the `</body>` option and save.

Lastly, we will add the following script before the closing `<body>` tag of our website’s main index page. This script allows the user to redirect back to the `/admin/` path after completing the login with the Netlify Identity Widget:

```html
<script>
  if (window.netlifyIdentity) {
    window.netlifyIdentity.on("init", (user) => {
      if (!user) {
        window.netlifyIdentity.on("login", () => {
          document.location.href = "/admin/";
        });
      }
    });
  }
</script>
```

**Step 5**

Now we’re all set. Since we set our registration preferences to **“Invite Only”**, we need to invite ourselves as site users. To do this, select the Identity tab from the Netlify site dashboard and select the Invite Users button. Add your email address and send an invitation. You will receive an email. In your email, click **“accept the invitation”**. You will be directed to your website admin sign-up panel. Choose a password. Now you are ready to log in to Netlify CMS.

# Setting up a custom domain

I﻿ bought a custom domain from [Namecheap](https://namecheap.com), they provide some pretty good deals. After pointing the nameservers for the domain to the Netlify nameservers, voila! everything worked smoothly. For HTTPS support, Netlify enables automatic TLS certificates with Let’s Encrypt.
