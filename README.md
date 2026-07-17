# Zest

*A DOM List Monad for modern web development.*

[![Hippocratic License HL3-CORE](https://img.shields.io/static/v1?label=Hippocratic%20License&message=HL3-CORE&labelColor=5e2751&color=bc8c3d)](https://firstdonoharm.dev/version/3/0/core.html)

Zest provides a monadic interface for interacting with the DOM, treating collections of elements as functional, iterable objects. It avoids the bloat of traditional libraries by using a modular mixin architecture and proxies to project specialized behaviors only when needed.

## Features

- **Monadic Interface**: Elements are managed as collections with functional combinators like `map` and `filter`.
- **Modular Mixins**: Functionality is composed via mixins, keeping the core API lean.
- **Proxies and Projections**: Complex behaviors (events, attributes, data) are accessed through specialized projections.
- **Modern Native APIs**: Built on top of modern browser standards like `IntersectionObserver` and `MutationObserver`.

## Installation

Use `pnpm` to install the package:

```bash
pnpm install @dashkite/zest
```

## Usage

The primary entry point is the `$` constructor, which generically dispatches over selectors, nodes, or iterables.

```coffeescript
import $ from "@dashkite/zest"

# Select elements
buttons = $ "button"

# Wrap existing nodes
body = $ document.body

# Use functional combinators
visible = 
  $ ".item"
    .filter ( el ) -> el.checkVisibility()

# Delegate events seamlessly
$ ".container"
  .listen "click"
  .within ".btn"
  .prevent()
  .apply ( e ) -> 
    # handle click logic here
```

## Other Resources

- [Reference](./docs/reference.md)
- [Recipes](./docs/recipes.md)
- [Technical Notes](./docs/technical-notes.md)
- [Testing](./docs/testing.md)
