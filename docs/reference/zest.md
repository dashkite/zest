# Zest Collection Reference

This document provides a detailed reference for the core `Zest` collection, which represents a monadic, normalized array of native DOM elements.

## Understanding the Zest Collection

The `Zest` class is the central abstraction of the Zest library. It behaves as a functor and monad over DOM elements. When you invoke operations like `map` or `filter`, you do not mutate the existing collection; instead, you receive a new, categorically normalized `Zest` instance.

Furthermore, the `Zest` class acts as the host for numerous modular mixins (such as properties, dimension, and form helpers) and proxies (such as `.attributes` and `.data`). These mixins extend the core collection to provide a unified, chainable interface spanning virtually all native DOM operations without needing to constantly drop down to raw iteration.

## Zest

The core class representing a monadic collection of DOM elements. This class implements the primary combinatorial, structural, and query methods.

### map:

$map: function \to Zest$

Executes a mapping function across all elements in the collection. Returns a new, categorically normalized Zest collection containing the results. If the mapping returns native elements, they are flattened and wrapped.

```coffeescript
import assert from "@dashkite/assert"
import $ from "@dashkite/zest"

tagNames = $ "div" .map ( el ) -> el.tagName
assert tagNames.first == "DIV"
```

### filter:

$filter: predicate \to Zest$

Evaluates a predicate function against all elements in the collection. Returns a new Zest collection containing only those elements for which the predicate returned a truthy value.

```coffeescript
import assert from "@dashkite/assert"
import $ from "@dashkite/zest"

activeItems = $ ".item" .filter ( el ) -> el.classList.contains "active"
assert activeItems.first.classList.contains "active"
```

### each:

$each: function \to Zest$

Iterates over every element in the collection, executing the provided function for its side effects. Returns the original Zest collection, making it ideal for method chaining.

```coffeescript
import $ from "@dashkite/zest"

$ ".item" .each ( el ) -> el.setAttribute "data-processed", "true"
```

### at:

$at: index \to node$

Retrieves the native DOM node located at the specified index within the collection's internal array. It supports negative indexing, allowing you to easily access elements from the end of the collection (e.g., `-1` for the last element).

```coffeescript
import assert from "@dashkite/assert"
import $ from "@dashkite/zest"

target = $ ".item"
assert target.at(-1) == target.last
```

### matches:

$matches: selector \to Zest$

Filters the collection by checking if each element natively matches the provided CSS selector string. Returns a new Zest collection containing the matched elements.

```coffeescript
import assert from "@dashkite/assert"
import $ from "@dashkite/zest"

matched = $ "div" .matches ".active"
assert matched.first?.matches ".active"
```

### first

$first \to node$

Property getter that returns the native DOM element situated at index `0` of the collection. Returns `undefined` if the collection is empty.

### last

$last \to node$

Property getter that returns the native DOM element situated at the very end of the collection. Returns `undefined` if the collection is empty.

### html

$html \to string$

Property getter/setter corresponding to the `innerHTML` DOM property. When read, it yields the `innerHTML` of the first element. When written to, it natively parses the HTML string (or node elements) and completely replaces the children of *all* elements in the collection.

```coffeescript
import $ from "@dashkite/zest"

$ "#container" .html = "<p>Replaced content</p>"
```

### render:

$render: html \to \emptyset$
$render: node \to \emptyset$

Accepts an HTML string or native node(s) and orchestrates an intelligent, in-place DOM mutation of the existing elements using the Flash DOM library. This provides highly efficient updates without the overhead of destroying and recreating DOM nodes.

```coffeescript
import $ from "@dashkite/zest"

$ "#container" .render "<ul><li>One</li></ul>"
```

### next

$next \to Zest$

Property getter that maps over the collection and returns a new Zest collection containing the `nextSibling` of each element.

### previous

$previous \to Zest$

Property getter that maps over the collection and returns a new Zest collection containing the `previousSibling` of each element.

### parent

$parent \to Zest$

Property getter that maps over the collection and returns a new Zest collection containing the `parentNode` of every element. It inherently deduplicates the parents if multiple children share the same parent node.

### children

$children \to Zest$

Property getter that retrieves all direct child nodes from the first element in the source collection and wraps them in a new Zest collection.

### query:

$query: selector \to Zest$

Executes `querySelectorAll` using the specified CSS selector within the scope of each element in the current collection. The results from all elements are flattened and returned as a new Zest collection.

```coffeescript
import assert from "@dashkite/assert"
import $ from "@dashkite/zest"

buttons = $ ".panel" .query "button.primary"
assert buttons.constructor.name == "Zest"
```

### closest:

$closest: selector \to Zest$

Maps over the collection, calling the native `closest()` method on each element using the provided CSS selector. Returns a new Zest collection containing the resulting ancestor nodes.

### attributes

$attributes \to proxy$

A property getter yielding a Proxy object that intercepts assignments and reads. Setting a property on this proxy sets the corresponding native attribute on all elements in the collection. Reading from it retrieves the native attribute from the first element.

```coffeescript
import assert from "@dashkite/assert"
import $ from "@dashkite/zest"

$ "#profile" .attributes.title = "User Profile"
assert $ "#profile" .first.getAttribute("title") == "User Profile"
```

### dataset

$dataset \to object$

A property getter that yields the raw, native `dataset` (DOMStringMap) from the first element in the collection.

### data

$data \to DataSet$

A property getter yielding a `DataSet` projection instance. This provides a robust, chainable interface (`get`, `set`, `remove`) for manipulating `data-*` attributes across the collection securely.

### properties

$properties \to proxy$

A property getter yielding a Proxy object designed for deep property assignment. Setting a property on this proxy assigns that exact property to every native element in the collection simultaneously, abstracting away manual iteration.

```coffeescript
import assert from "@dashkite/assert"
import $ from "@dashkite/zest"

$ ".submit-button" .properties.disabled = true
assert $ ".submit-button" .first.disabled == true
```

### id

$id \to string$

A property getter/setter mapping to the native `id` property. When read, it yields the `id` of the first element. When assigned, it sets the `id` on all elements in the collection.

### name

$name \to string$

A property getter/setter mapping to the native `name` property across the collection.

### value

$value \to string$

A property getter/setter mapping to the native `value` property across the collection. Useful for interacting with input fields.

### text

$text \to string$

A property getter/setter mapping to the native `innerText` property. Reading yields the text of the first element; writing updates the text of all elements.

### classes

$classes \to Classes$

A property getter yielding a `Classes` projection instance. This projection manages native `classList` operations (`add`, `remove`, `toggle`) across the collection declaratively.

### form

$form \to Form$

A property getter yielding a `Form` projection instance focused on the first form element in the collection. Useful for converting form inputs directly into a data payload object.

### modify

$modify \to Modify$

A property getter yielding a `Modify` projection instance. This provides a simplified, declarative API for setting up native `MutationObserver` instances across the collection.

### show:

$show: handler \to \emptyset$

Wraps the native `IntersectionObserver` API. It accepts a handler function and invokes it, passing the target element, the moment any element in the collection intersects the browser viewport (becomes visible).

```coffeescript
import $ from "@dashkite/zest"

$ ".lazy-image" .show ( el ) ->
  console.log "Image became visible."
```

### hide:

$hide: handler \to \emptyset$

Wraps the native `IntersectionObserver` API. It accepts a handler function and invokes it when the elements in the collection leave the browser viewport (become invisible).

### files

$files \to Files$

A property getter yielding a `Files` projection instance. It simplifies interactions with `<input type="file">` elements, such as easily extracting object preview URLs.

### slots

$slots \to object$

A property getter that scans the first element in the collection for `<slot>` definitions and returns a plain object mapping slot names to their respective native elements.

### slotted

$slotted \to Slotted$

A property getter yielding a `Slotted` projection instance. It provides an intuitive interface for querying nodes that have been assigned to specific Web Component slots.

### listen:

$listen: eventname \to Listener$

Initiates an event listener configuration pipeline. It returns a `Listener` handler object that allows you to chain modifiers (like `.prevent()` or `.within()`) before finalizing the listener attachment.

```coffeescript
import $ from "@dashkite/zest"

$ ".form"
  .listen "submit"
  .prevent()
  .apply ( e ) -> console.log "Submission intercepted"
```

### capture:

$capture: eventname \to Listener$

Initiates an event listener configuration exactly like `.listen()`, but automatically sets the native `capture: true` phase flag on the underlying configuration.

### dispatch:

$dispatch: name \to \emptyset$
$dispatch: object \to \emptyset$

Triggers a synchronous custom event on all elements in the collection. It accepts either a simple string for the event name, or an object containing `{ name, detail }` to broadcast a payload alongside the event.

```coffeescript
import $ from "@dashkite/zest"

$ ".component" .dispatch 
  name: "state-changed"
  detail: { status: "ready" }
```

### click:

$click: \to \emptyset$

A convenience method that simulates a native click on all elements in the collection.

### focus:

$focus: \to \emptyset$

A convenience method that triggers the native focus action specifically on the first element in the collection.

### blur:

$blur: \to \emptyset$

A convenience method that triggers the native blur action on all elements in the collection, removing focus.

### select:

$select: \to \emptyset$

A convenience method that triggers the native select action specifically on the first element in the collection, highlighting its textual content.
