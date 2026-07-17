# Constructor Reference

This document provides a detailed reference for the universal `$` constructor function, which serves as the primary entry point for the Zest library.

## Understanding the $ Constructor

The Zest API is designed around a single, highly generic entry point: the `$` function. Instead of requiring developers to use separate functions like `querySelectorAll`, `createElement`, or `wrapNode`, Zest uses a generic dispatch system to interpret the input.

When you pass an argument to `$`, it evaluates the type and shape of the input to determine the appropriate strategy. It can gracefully handle empty inputs, CSS selectors, raw HTML strings, existing native DOM nodes, or even iterables like arrays and generators. Regardless of the input, the output is consistently a normalized, chainable Zest collection.

## Zest Factory

The core factory interface responsible for instantiating new Zest collections.

### $

$\text{\$}: \to Zest$
$\text{\$}: nullish \to Zest$
$\text{\$}: generator \to Zest$
$\text{\$}: iterable \to Zest$
$\text{\$}: selector, root \to Zest$
$\text{\$}: selector \to Zest$
$\text{\$}: html \to Zest$
$\text{\$}: node \to Zest$

Evaluates the provided arguments and constructs a new Zest collection. 

- **Empty or Nullish**: Passing nothing, `null`, or `undefined` returns an empty Zest collection.
- **Selector**: Passing a string that represents a valid CSS selector queries the document (or a provided `root` node) and wraps the results.
- **HTML String**: Passing a string that looks like HTML (e.g., `<div/>`) invokes the native browser parser to create new, unattached DOM nodes and wraps them.
- **Nodes & Iterables**: Passing a single `Node`, an array of nodes, a `NodeList`, or a generator function wraps those specific elements into the collection, flattening and deduplicating them automatically.

```coffeescript
import assert from "@dashkite/assert"
import $ from "@dashkite/zest"

# 1. Select elements from the DOM
items = $ ".item"
assert items.constructor.name == "Zest"

# 2. Wrap an existing native node
body = $ document.body
assert body.first == document.body

# 3. Construct from an iterable array of nodes
list = $ [ document.createElement("div"), document.createElement("p") ]
assert list.first.tagName == "DIV"
assert list.last.tagName == "P"

# 4. Parse HTML strings into living, unattached nodes
template = $ "<button class='btn'>Click Me</button>"
assert template.first.tagName == "BUTTON"
assert template.first.classList.contains "btn"
assert template.first.innerText == "Click Me"

# 5. Scope a query using a specific root element
container = document.querySelector ".container"
scopedItems = $ ".item", container
assert scopedItems.constructor.name == "Zest"
```
