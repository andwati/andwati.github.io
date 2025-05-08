---
title : "Configure Vue.js app With Tailwind CSS"
description : "Tailwindcss in vuejs "
date : 2021-06-12 +0300
tags : ["javascript", "vuejs" , "tailwindcss"]
---
A guide on how to use [Tailwind CSS](https://tailwindcss.com/) in your Vue project.

<!-- more -->

>**Note**  
> This article was originaly published on my old  medium blog. I moved it here for archival purposes. 

Tailwind is a utility-first CSS framework for rapidly building custom user interfaces. It is an un-opinionated framework which means that it doesn't come with custom configurations like Bootstrap or Bulma(Yeah, I know, no one should tell you how to live your life).

Now let's get to the juicy part that brought us all here. I'll assume that we are using Vue 3 and the Vue CLI is already installed.

## Create a new Vue project
Open a terminal window and type the following commands to create a new Vue project in the current directory.

```sh
vue create vue-app
```
wait for the dependencies installation to finish then

```sh
cd vue-app
```

to change into the project directory.

## Install the Tailwind CSS and its peer dependencies as a dev dependency using npm

```sh
npm install -D tailwindcss@latest postcss@latest autoprefixer@latest
```

## Create your configuration files
Next, generate your `tailwind.config.js` and `postcss.config.js` files:

```sh
npx tailwindcss init -p
```

This command will create a minimal `tailwind.config.js` file at the root of your project:

```js
// tailwind.config.js
module.exports = {
  purge: [],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {},
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
```

It will also create a `postcss.config.js` file that includes tailwindcss and autoprefixer already configured.Postcss is needed to process tailwind:

```js
// postcss.config.js
module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
}
```

## Configure Tailwind to remove unused styles in production
In your tailwind.config.js file, configure the purge option with the paths to all of your pages and components so Tailwind can tree-shake unused styles in production builds:

```js
// tailwind.config.js
  module.exports = {
    purge: ['./index.html', './src/**/*.{vue,js,ts,jsx,tsx}'],
    darkMode: false, // or 'media' or 'class'
    theme: {
      extend: {},
    },
    variants: {
      extend: {},
    },
    plugins: [],
  }
```

## Include Tailwind in your CSS
Navigate to `src/assets/css` and create a new `tailwind.css` file in the folder, and use the @tailwind directive to include Tailwind’s base, components, and utilities styles in the file.

```css
/* ./src/assets/css/tailwind.css */
@tailwind base;
@tailwind components;
@tailwind utilities;
```

Tailwind will swap these directives out at build-time with all of the styles it generates based on your configured design system.

## Import Tailwind into your Vue app
Finally, ensure your CSS file is being imported in your `./src/main.js` file:

```js
// src/main.js
import { createApp } from 'vue'
import App from './App.vue'
import './index.css'

createApp(App).mount('#app')
```

You're finished! Now when you run npm run dev, Tailwind CSS will be ready to use in your Vue app! You can now proceed to create awesome stuff

