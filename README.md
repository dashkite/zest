# Zest

*A DOM List Monad for modern web development.*

[![Hippocratic License HL3-CORE](https://img.shields.io/static/v1?label=Hippocratic%20License&message=HL3-CORE&labelColor=5e2751&color=bc8c3d)](https://firstdonoharm.dev/version/3/0/core.html)

Zest provides a monadic interface for interacting with the DOM, treating collections of elements as functional, iterable objects. It avoids the bloat of traditional libraries by using a modular mixin architecture and proxies to project specialized behaviors only when needed.

For example, selecting all buttons in a container and preventing their default click behavior is concise and chainable:

```coffeescript
import $ from "@dashkite/zest"

$ ".btn", container
  .listen "click"
  .prevent()
  .apply ( e ) -> 
    # handle click
```

### Features
- **Monadic Interface**: Elements are managed as collections with functional combinators like `map` and `filter`.
- **Modular Mixins**: Functionality is composed via mixins, keeping the core API lean.
- **Proxies & Projections**: Complex behaviors (events, attributes, data) are accessed through specialized projections.
- **Modern Native APIs**: Built on top of modern browser standards like `IntersectionObserver` and `MutationObserver`.

## Installation

Use your favorite package manager to install:

```bash
pnpm add @dashkite/zest
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
```

## Other Resources
- [Reference](./docs/reference.md): Detailed API documentation for the `$` constructor and Zest methods.
- [Recipes](./docs/recipes.md): Task-based guides for common DOM interaction scenarios.

## Status
This software is currently in active development and is not yet suitable for production use. Please report bugs or request features via the repository's issue tracker.
