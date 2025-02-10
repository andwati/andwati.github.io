# [https://andwati.github.io](https://andwati.github.io)
## Stack
- [Zola](https://www.getzola.org/) - Your one-stop static site engine
Forget dependencies. Everything you need in one binary.
- [Utterances](https://github.com/utterance/utterances) - A lightweight comments widget built on GitHub issues
- [Goatcounter](https://www.goatcounter.com/) - GoatCounter is an open source web analytics platform available as a free donation-supported hosted service or self-hosted app. It aims to offer easy to use and meaningful privacy-friendly web analytics as an alternative to Google Analytics or Matomo

## Build
Fork and rename the repository to `<username>.github.io` .

> **Note**  
> This is only required if you are going to publish the site using github pages.

clone the repository

```sh
git clone https://github.com/<username>/<username>.github.io
```

```
cd <username>.github.io
```
To launch the development server

```sh
zola serve
```

## Deploying
Currently my copy is deployed to github pages using an actions workflow in `.github/workflows/main.yml`

Check other deploy options and how to setup a custom domain  in the zola docs at [https://www.getzola.org/documentation/deployment/github-pages/](https://www.getzola.org/documentation/deployment/github-pages/)

## Adding Content
The blog post content is in `content/posts`. create a markdown file and copy the front matter from any of the existing posts.

## Setting up the commenting system
currently just change the repo name in `templates\_partials\comments.html`

## TODO
- [ ] create new post script
- [ ] add google analytics
- [ ] move goatcounter config to config.toml
- [ ] modularize open graph(og) tags
- [ ] add favicon to config
- [ ] add latex support