---
title: "Subresource Integrity"
date: 2023-04-29
# weight: 1
# aliases: ["/first"]
tags: ["Subresource Integrity"]
author: "Ian Andwati"
# author: ["Me", "You"] # multiple authors
showToc: false
TocOpen: false
draft: false
hidemeta: false
comments: false
description: "Understanding Subresource Integrity"
canonicalURL: ""
disableHLJS: true # to disable highlightjs
disableShare: false
disableHLJS: false
hideSummary: false
searchHidden: true
ShowReadingTime: true
ShowBreadCrumbs: true
ShowPostNavLinks: true
ShowWordCount: true
ShowRssButtonInSectionTermList: true
UseHugoToc: true
---

Understanding Subresource Integrity

<!-- more -->

In my junior year while I was learning HTML and CSS I got to use the Bootstrap css library.The easiest way to obtain the files was from a Content Delivery Network(CDN). I could see links such as:

```html
<link
  href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
  rel="stylesheet"
  integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ"
  crossorigin="anonymous"
/>
```

I didnt bother with the `integrity` attribute of the link(guess I wasnt curios enough). The integrity attribute has a cryptographic hash value that is important in CDNs and its called the Subresource Integrity.

Subresource Integrity (SRI) is a security feature in web browsers that helps prevent malicious or compromised scripts from being loaded and executed on a website.a security feature that enables browsers to verify that resources they fetch (for example, from a CDN) are delivered without unexpected manipulation. It works by allowing you to provide a cryptographic hash that a fetched resource must match.

When a resource, such as a script or stylesheet, fails the SRI check, the browser will block the resource from being loaded and displayed on the website.

# How Subresource Integrity Helps

Subresource Integrity (SRI) is a security feature that helps protect against certain types of attacks, such as those that involve malicious modifications to third-party resources that a website loads.

SRI works by allowing a website to specify a cryptographic hash for a particular external resource (such as a JavaScript file or a CSS stylesheet) that it expects to load. When a user's browser fetches that resource, it checks the hash against the actual contents of the resource. If the hash doesn't match, the browser will refuse to load the resource, indicating that it may have been tampered with.

This can help prevent a variety of attacks, such as those involving a compromised content delivery network (CDN) or a man-in-the-middle attacker who intercepts and modifies network traffic. By using SRI, a website can help ensure that it is loading only the resources it expects, and that those resources have not been tampered with in transit.

# Using it

Using Subresource Integrity (SRI) involves a few steps, but it is relatively straightforward.An integrity value begins with at least one string, with each string including a prefix indicating a particular hash algorithm (currently the allowed prefixes are sha256, sha384, and sha512), followed by a dash, and ending with the actual base64-encoded hash.

- Generate a cryptographic hash(a base64-encoded cryptographic hash) of the external resource you want to load on your website. This can be done using a hash function such as SHA-256.

- Add the hash as an attribute to the tag that loads the external resource. For example, for a JavaScript file, you would add the integrity attribute to the `<script>` tag like this:

```html
<script
  src="https://example.com/example.js"
  integrity="sha256-ABC123XYZ456"
></script>
```

> An integrity value may contain multiple hashes separated by whitespace. A resource will be loaded if it matches one of those hashes.

Make sure the hash you've generated matches the actual contents of the external resource.

Test your website to ensure that the external resource is loading correctly and that the SRI feature is working as intended.

# Tools for generating SRI hashes

You can use a tool such as the [SRI Hash Generator](https://www.srihash.org/) to generate the hash and check it against the file's contents.

You can generate SRI hashes from the command-line with openssl using a command invocation such as:

```sh
cat FILENAME.py | openssl dgst -sha384 -binary | openssl base64 -A
```

or with shasum using a command invocation such as:

```sh
shasum -b -a 384 FILENAME.js | awk '{ print $1 }' | xxd -r -p | base64
```

> The pipe-through xxd step takes the hexadecimal output from shasum and converts it to binary.
> The pipe-through awk step is necessary because shasum will pass the hashed filename in its output to xxd. That can have disastrous consequences if the filename happens to have valid hex characters in it — because xxd will also decode that and pass it to base64.

In a Windows environment, you can create a tool for generating SRI hashes with the following code:

```bat
@echo off
set bits=384
openssl dgst -sha%bits% -binary %1% | openssl base64 -A > tmp
set /p a= < tmp
del tmp
echo sha%bits%-%a%
pause
```

To use that code:

1. Save that code in a file named sri-hash.bat in the Windows SendTo folder in your environment (for example, C:\Users\USER\AppData\Roaming\Microsoft\Windows\SendTo).
1. Right-click a file in the File Explorer, select Send to…, and then select sri-hash. You will see the integrity value in a command box.
1. Select the integrity value and right-click to copy it to the Clipboard.
1. Press any key to dismiss the command box

# Cross-Origin Resource Sharing and Subresource Integrity

When verifying the subresource integrity of a resource that originates from a different domain than the document it's embedded in, web browsers will check the resource using Cross-Origin Resource Sharing (CORS) to ensure that the domain serving the resource allows it to be shared with the requesting domain.
As a result, the resource must be served with an Access-Control-Allow-Origin header that permits the resource to be shared with the requesting domain. For example, the header could include a wildcard (\*) to allow any domain to access the resource.

```
Access-Control-Allow-Origin: *
```

# How browsers handle Subresource Integrity

Web browsers employ several mechanisms to handle Subresource Integrity (SRI). When a <script> or <link> element with an integrity attribute is encountered by the browser, it compares the script or stylesheet to the expected hash given in the integrity value before executing the script or applying the stylesheet.

For resources served from a different domain than the document in which it's embedded, the browser also checks the resource using Cross-Origin Resource Sharing (CORS) to ensure that the origin serving the resource allows it to be shared with the requesting domain. This additional check is important for preventing unauthorized access to sensitive resources.

If the script or stylesheet fails to match its associated integrity value, the browser will refuse to execute the script or apply the stylesheet and return a network error, indicating that the fetching of that script or stylesheet failed. This behavior ensures that the resource being loaded is trustworthy and helps to protect users from potential security threats.

# References

- https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP
- https://www.srihash.org/
- https://developer.mozilla.org/en-US/docs/Web/Security/Subresource_Integrity
- https://html.spec.whatwg.org/multipage/semantics.html#attr-script-integrity
- https://html.spec.whatwg.org/multipage/semantics.html#attr-link-integrity
- https://w3c.github.io/webappsec-subresource-integrity/#the-integrity-attribute
