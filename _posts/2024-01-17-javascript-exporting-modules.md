---
title : Export default and module.exports in Javascript
date : 2024-01-17
tags : [javascript, node]
---

Javascript is a popular programming language that can run both in the browser and on the server. However, different environments may have different ways of organizing and importing Javascript modules. In this article, we will compare two common methods of exporting and importing modules: **export default** and **module.exports**.


## What are modules?
Modules are reusable pieces of code that can be separated into different files. Modules can export values, functions, classes, or objects that can be imported by other modules. This way, modules can avoid polluting the global scope and enable code reuse and modularity.

## How to export modules in Node.js?
Node.js is a runtime environment that allows Javascript to run on the server. Node.js uses a module system called CommonJS, which is based on the require and module.exports syntax.

To export a module in Node.js, you can assign the value that you want to export to the module.exports object. For example:

```javascript
// my-module.js
// export a function
module.exports = function add(a, b) {
  return a + b;
};

// export an object
module.exports = {
  name: "Alice",
  age: 25,
};
```

To import a module in Node.js, you can use the require function and pass the path of the module file as an argument. The require function will return the value of module.exports from the module file. For example:

```javascript
// main.js
// import a function
const add = require("./my-module.js");
console.log(add(2, 3)); // 5

// import an object
const person = require("./my-module.js");
console.log(person.name); // Alice
console.log(person.age); // 25
```

Note that Node.js will cache the modules that are imported with require, so if you import the same module multiple times, you will get the same instance of the module.

## How to export modules in ES6?
ES6 is the  version of Javascript that introduced many new features, including a native module system. ES6 modules use the `import` and `export` syntax.

To export a module in ES6, you can use the `export` keyword followed by the declaration of the value that you want to export. You can also use the export keyword with curly braces to export a list of named values. For example:

```javascript
// my-module.js
// export a function
export function add(a, b) {
  return a + b;
}

// export a class
export class Person {
  constructor(name, age) {
    this.name = name;
    this.age = age;
  }
}

// export an object
export const person = {
  name: "Alice",
  age: 25,
};
```

To import a module in ES6, you can use the `import` keyword followed by the name of the value that you want to import and the path of the module file. You can also use the import keyword with curly braces to import a list of named values. For example:

```javascript
// main.js
// import a function
import { add } from "./my-module.js";
console.log(add(2, 3)); // 5

// import a class
import { Person } from "./my-module.js";
const person = new Person("Bob", 30);
console.log(person.name); // Bob
console.log(person.age); // 30

// import an object
import { person as Alice } from "./my-module.js";
console.log(Alice.name); // Alice
console.log(Alice.age); // 25
```
Note that ES6 modules are imported and executed only once, so if you import the same module multiple times, you will get the same instance of the module.

## What is the difference between export default and module.exports?
One of the main differences between export default and module.exports is that export default is an ES6 feature, while module.exports is a CommonJS feature. Therefore, they are not compatible with each other by default. However, some tools like Babel or Webpack can transpile ES6 modules to CommonJS modules, or vice versa, to make them work together.

Another difference is that export default can only export one value per module, while module.exports can export any value, including multiple values. For example:

```javascript
// my-module.js
// export default a function
export default function add(a, b) {
  return a + b;
}

// export default an object
export default {
  name: "Alice",
  age: 25,
};

// export default a class
export default class Person {
  constructor(name, age) {
    this.name = name;
    this.age = age;
  }
}
```

```javascript
// my-module.js
// export a function
module.exports = function add(a, b) {
  return a + b;
};

// export an object
module.exports = {
  name: "Alice",
  age: 25,
};

// export a class
module.exports = class Person {
  constructor(name, age) {
    this.name = name;
    this.age = age;
  }
};
```

Note that you can only have one export default statement per module, but you can have multiple module.exports statements. However, each module.exports statement will overwrite the previous one, so only the last one will be exported.

To import a default export, you can use the import keyword without curly braces and assign any name to the imported value. For example:

```javascript
// main.js
// import a default export
import add from "./my-module.js";
console.log(add(2, 3)); // 5

// import another default export
import person from "./my-module.js";
console.log(person.name); // Alice
console.log(person.age); // 25

// import another default export
import Person from "./my-module.js";
const person = new Person("Bob", 30);
console.log(person.name); // Bob
console.log(person.age); // 30
```

To import a module.exports value, you can use the require function and assign any name to the imported value. For example:
```javascript
// main.js
// import a module.exports value
const add = require("./my-module.js");
console.log(add(2, 3)); // 5

// import another module.exports value
const person = require("./my-module.js");
console.log(person.name); // Alice
console.log(person.age); // 25

// import another module.exports value
const Person = require("./my-module.js");
const person = new Person("Bob", 30);
console.log(person.name); // Bob
console.log(person.age); // 30
```
Node’s JavaScript has diverged from that of the browser. Understanding both CommonJS modules and ES6 modules is your first step in becoming a 10X developer. Happy coding!