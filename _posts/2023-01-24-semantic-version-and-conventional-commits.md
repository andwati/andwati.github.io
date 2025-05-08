---
title: "Semantic Versioning(SemVer) and Conventional  Commits"
description : "Adopting best practices in your git and build workflows."
date: 2023-01-24
tags: ["git", "semver","workflow", "conventional commits"]
---

Adopting best practices in your git and build workflows.

<!-- more -->

# What is Semver?

Semantic versioning or just SemVer is a dependency naming guidline that aims to bring some sanity into naming libraries and packages in software development. It is a standard versioning system created by **Tom Preston Werner** (co-founder of Github) that’s used to communicate what changes are in a release.

An efficient and smooth versioning becomes crucial for efficient software delivery expecially for projects that expose a public API. This saves the developers the chaos that is **dependency hell**.Dependency hell is a colloquial term for the frustration of some software users who have installed software packages which have dependencies on specific versions of other software packages.

The dependency issue arises when several packages have dependencies on the same shared packages or libraries, but they depend on different and incompatible versions of the shared packages. If the shared package or library can only be installed in a single version, the user may need to address the problem by obtaining newer or older versions of the dependent packages. This, in turn, may break other dependencies and push the problem to another set of packages.

## Semantic Versioning Specifications

### Summary

Semantic versioning is based on three numbers that indicate the versions of the software and the compatibilities.They are `X.Y.Z` corresponding to `Major.Minor.Patch`

- **Major Version (X):**Introduces major changes to the code and breaking changes toward backward compatibility
- **Minor Version (Y):** These code changes don’t introduce breaking changes. This could be adding a new feature that doesn't break changes but are not exactly bug fixes.
- **Patches (Z):** Mainly correspond to bug fixes

### Examples in common packages

#### React(v18.2.0)

- **Major -> 18**
- **Minor -> 2**
- **Patch -> 0**

---

#### Pipx(v1.1.0)

- **Major -> 1**
- **Minor -> 1**
- **Patch -> 0**

---

## Start at v0.1.0 or v1.0.0?

Convention recommends that in the initial development phase the starting version should be 0.1.0 which makes sense since it’s not in production yet.

The version should only be bumped to 1.0.0 only if it is being used in production and stable.

If your software is being used in production, it should probably already be 1.0.0. If you have a stable API on which users have come to depend, you should be 1.0.0. If you’re worrying a lot about backwards compatibility, you should probably already be 1.0.0.

# Conventional Commits

Conventional Commits is a convention on top of commit messages that are used to automate version changes. It provides an easy set of rules for creating commit messages and works well with SemVer by describing features, fixes and breaking changes that correspond to SemVer standards.

## Summary

The commit message should be structured as follows:

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

The commit contains the following structural elements, to communicate intent to the consumers of your library:

1. fix: a commit of the type fix patches a bug in your codebase (this correlates with PATCH in Semantic Versioning).
2. feat: a commit of the type feat introduces a new feature to the codebase (this correlates with MINOR in Semantic Versioning).
3. BREAKING CHANGE: a commit that has a footer BREAKING CHANGE:, or appends a ! after the type/scope, introduces a breaking API change (correlating with MAJOR in Semantic Versioning). A BREAKING CHANGE can be part of commits of any type.
4. types other than fix: and feat: are allowed, for example @commitlint/config-conventional (based on the Angular convention) recommends build:, chore:, ci:, docs:, style:, refactor:, perf:, test:, and others.
5. footers other than BREAKING CHANGE: <description> may be provided and follow a convention similar to git trailer format.

# Resources

[https://semver.org/](https://semver.org/)
[https://www.conventionalcommits.org/en/v1.0.0/](https://www.conventionalcommits.org/en/v1.0.0/)
