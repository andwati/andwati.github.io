---
title : "What say you?"
description : "Adding a comment system by utterances"
author : "Ian Andwati"
date : 2023-08-24
tags : ["blog", "utterances"]
---

Free speech enhanced

<!-- more -->

There is no point in writing online if your readers cannot provide feedback for your writings. You might as well be shouting at a void. My ideal commenting system has to be free, open source and should not be a hassle to setup. Luckily, [utterances 🔮](https://github.com/utterance/utterances) checks all of these conditions

It is a lightweight comments widget built on GitHub issues. Use GitHub issues for blog comments, wiki pages and more! The notable features are:

- Open source. 🙌
- No tracking, no ads, always free. 📡🚫
- No lock-in. All data stored in GitHub issues. 🔓
- Styled with Primer, the css toolkit that powers GitHub. 💅
- Dark theme. 🌘
- Lightweight. Vanilla TypeScript. No font downloads, JavaScript frameworks or polyfills for evergreen browsers. 🐦🌲

## How it works

When Utterances loads, the GitHub [issue search API](https://developer.github.com/v3/search/#search-issues) is used to find the issue associated with the page based on url, pathname or title. If it cannot find an issue that matches the page, [utterances-bot](https://github.com/utterances-bot) will automatically create an issue the first time someone comments.

To comment, users must authorize the utterances app to post on their behalf using the GitHub [OAuth flow](https://developer.github.com/v3/oauth/#web-application-flow). Alternatively, users can comment on the GitHub issue directly.

# Setting up Utterances

### Repository

Choose the repository utterances will connect to.

Make sure the repo is public, otherwise your readers will not be able to view the issues/comments.
Make sure the utterances app is installed on the repo, otherwise users will not be able to post comments.
If your repo is a fork, navigate to its settings tab and confirm the issues feature is turned on.

```
repo:
    username/repo
```

A public GitHub repository. This is where the blog post issues and issue-comments will be posted.

### Theme

Choose an Utterances theme that matches your blog.

### Enable Utterances

Add the following script tag to your blog's template. Position it where you want the comments to appear. Customize the layout using the .utterances and .utterances-frame selectors.

```js
<script
  src="https://utteranc.es/client.js"
  repo="[ENTER REPO HERE]"
  issue-term="title"
  theme="gruvbox-dark"
  crossorigin="anonymous"
  async
></script>
```

The complete documentation can be found at [https://utteranc.es](https://utteranc.es/)
