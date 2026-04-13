# Zest Reference

Detailed API documentation for the Zest DOM monad and its core mixins.

## The `$` Constructor

The `$` function is a generic constructor that wraps DOM elements or queries the document to create a Zest collection.

#### $
$\text{\$} \to Zest$

$\text{\$} : nullish \to Zest$

$\text{\$} : generator \to Zest$

$\text{\$} : iterable \to Zest$

$\text{\$} : selector: string, root: node \to Zest$

$\text{\$} : selector: string \to Zest$

$\text{\$} : html: string \to Zest$

$\text{\$} : node: node \to Zest$

Creates a Zest collection from the given input. If no input or nullish input is provided, returns an empty collection. HTML strings are parsed into element nodes.

```coffeescript
# Select nodes
items = $ ".item"

# Wrap existing nodes
body = $ document.body
```

## Core Methods

### Categorical Operations

#### map
$map: function \to Zest$

Given a mapping function, returns a new Zest collection where each element has been transformed by the function.

```coffeescript
tagNames = $ "div" .map ( el ) -> el.tagName
```

#### filter
$filter: function \to Zest$

Returns a new Zest collection containing only those elements for which the predicate function returns true.

```coffeescript
activeItems = $ ".item" .filter ( el ) -> el.classList.contains "active"
```

#### each
$each: function \to Zest$

Executes the provided function for each element in the collection. Returns the original Zest collection to enable chaining.

```coffeescript
$ ".item" .each ( el ) -> console.log el.id
```

### Element Access

#### at
$at: index: number \to node$

Returns the element at the specified index. Supports negative indices to access elements from the end of the collection.

```coffeescript
assert $ ".item" .at -1 == $ ".item" .last
```

#### first
$first \to node$

Getter that returns the first element in the collection.

#### last
$last \to node$

Getter that returns the last element in the collection.

## Mixins & Projections

Zest uses a modular mixin system to extend the base collection. Many complex behaviors are accessed via projections (getters returning specialized handlers).

### Attributes & Data

#### attributes
$attributes \to Proxy$

A Proxy that provides a direct object-like interface to the attributes of the **first** element in the collection.

```coffeescript
$ "#profile" .attributes.title = "User Profile"
```

#### data
$data \to Proxy$

A Proxy that provides a clean interface to the `dataset` of the **first** element.

```coffeescript
console.log $ "#user" .data.userId
```

### Events

#### listen
$listen: eventName: string \to Listener$

Initiates an event listener configuration. Returns a `Listener` handler that can be further configured with filters and behaviors before applying the handler.

**Listener Methods:**
- $prevent: \to Listener$
- $stop: \to Listener$
- $within: selector: string \to Listener$
- $apply: handler: function \to undefined$

```coffeescript
$ ".form"
  .listen "submit"
  .prevent()
  .apply ( e ) -> handleSubmit e
```

### Navigation

#### children
$children \to Zest$

Getter returning a new Zest collection of all child elements for every node in the source collection.

#### parent
$parent \to Zest$

Getter returning a new Zest collection of all parent nodes for every element in the collection.

#### query
$query: selector: string \to Zest$

Runs `querySelectorAll` using the given selector within each element of the current collection.

## Technical Notes

### Categorical Normalization

Zest collections are automatically flattened and unique upon creation, ensuring that operations like `map` and `filter` don't result in nested or duplicate element sets.
