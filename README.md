# DashKite Zest

*DOM List Monad*

[![Hippocratic License HL3-CORE](https://img.shields.io/static/v1?label=Hippocratic%20License&message=HL3-CORE&labelColor=5e2751&color=bc8c3d)](https://firstdonoharm.dev/version/3/0/core.html)

Inspired by JQuery, Zest provides a monadic interface for interacting with the DOM. It treats collections of DOM elements as iterable objects, using **Mixins** to compose functionality and **Proxies** to project into specialized interfaces without polluting the core namespace.

## The `$` Constructor

The `$` function is a generic dispatcher used to wrap elements or query the DOM.

```coffeescript
import $ from "@dashkite/zest"

# Selectors
$ ".item"               # document.querySelectorAll
$ ".item", container    # container.querySelectorAll

# Direct Wrappers
$ document.body         # Single Node
$ [ el1, el2 ]            # Iterable/Array

# HTML Parsing
$ "<div class='new'>"   # Creates elements from HTML string

# Functional
$ -> yield el           # Wraps a Generator Function

```

---

## Categorical Operations (Core)

Zest collections implement the iterator protocol and provide functional transformation methods. Because Zest uses `Arr.normalize`, collections are guaranteed to be flat and unique.

* **`map(fn)`**: Returns a new Zest collection by applying `fn` to each element.
* **`filter(fn)`**: Returns a new Zest collection containing only elements that satisfy the predicate.
* **`each(fn)`**: Executes `fn` for each element. Returns the original collection for chaining.
* **`at(n)`**: Returns the element at index `n`.
* **`first` / `last**`: Getters for the first and last elements in the collection.

---

## Projections & Specialized Interfaces

Zest uses a "projection" pattern where complex behaviors are accessed through getters that return specialized handlers. This keeps the base collection API clean.

### Attributes & Data

Proxies are used to provide a clean, object-like interface to DOM attributes and datasets.

* **`.attributes`**: A Proxy reflecting the attributes of the **first** element.
* **`.data`**: A Proxy reflecting the `dataset` of the **first** element via a `Handler`.
* **`.dataset`**: Direct access to the `HTML5 dataset` property.

```coffeescript
# Get/Set via Proxy
$el.attributes.title = "Zest Documentation"
console.log $el.data.userId

```

### Events

The `events` mixin provides a fluent, chainable API for event management.

* **`listen(event)`**: Returns a `Listener` for the specified event.
* **`capture()`**: Initiates a listener in the capture phase.
* **`dispatch(name)`** or **`dispatch({ name, detail... })`**: Dispatches a `CustomEvent` that bubbles and is composed.

**Listener Methods:**
Chainable filters that modify the execution of the handler:

* `stop()`, `prevent()`, `intercept()`: Stop propagation and/or prevent default.
* `matches(selector)`: Only triggers if the target matches the selector.
* `within(selector)`: Only triggers if the target is within a selector (using `closest`).
* `apply(handler)`: Binds the final logic to the chain.

```coffeescript
$ ".btn"
  .listen "click"
  .prevent()
  .within ".container"
  .apply (e) -> console.log "Scoped click within container"

```

---

## DOM Navigation & Traversals

### Navigators

Categorical movement through the DOM tree. Getters like `next` and `parent` return new Zest collections containing the relative nodes for every element in the source collection.

* **`next` / `previous**`: Getters returning collections of the immediate siblings.
* **`parent`**: Returns a collection of parent nodes.
* **`children`**: Returns a Zest collection of all `childNodes` of the first element.
* **`query(selector)`**: Runs `querySelector` on each element.
* **`closest(selector)`**: Finds the nearest ancestor matching the selector for each element in the set.

---

## Observers & Intersection

Zest wraps complex async browser APIs into clean, functional callbacks using the `modify`, `show`, and `hide` interfaces.

* **`.modify`**: Accesses `MutationObserver` logic.
* `attributes(names, handler)`: Watch for changes to specific attributes.
* `children(handler)`: Watch for immediate child additions/removals.
* `descendents(handler)`: Watch the entire subtree.


* **`.show(handler)`**: Triggers when an element becomes visible (via `IntersectionObserver`).
* **`.hide(handler)`**: Triggers when an element is hidden.

---

## Web Component Support (Slots)

Zest provides first-class support for Shadow DOM slots and assigned nodes.

* **`.slots`**: Returns a dictionary mapping slot names to the corresponding elements.
* **`.slotted`**: A projection for accessing nodes assigned to slots within the collection.
* `named(name)`: Nodes assigned to a specific named slot.
* `anonymous()`: Nodes assigned to the default slot.
* `all()`: All assigned nodes.



---

### Technical Implementation Note

Zest utilizes a **Flat-Type** architecture via the `metaclass` pattern. This allows the `Zest` class to be composed of many mixins (Attributes, Classes, Events, etc.) while maintaining a single prototype chain, ensuring that `instanceof Zest` remains a reliable check.

## JQuery Comparison

While Zest shares the familiar `$` constructor with JQuery, it takes full advantage of modern JavaScript and browser APIs. 


### Selection & Context

The basic starting point is the same:

| Task | jQuery | Zest |
| --- | --- | --- |
| **Select** | `$(".item")` | `$(".item")` |
| **Context** | `$(".item", root)` | `$(".item", root)` |
| **Create** | `$("<div>")` | `$("<div>")` |

### Events: From `.on()` to `.listen()`

Zest replaces the overloaded `.on()` method with a chainable `listen` projection. This separates the event configuration (filters, stops, prevents) from the actual handler.

**Recipe: Delegation**

```coffeescript
# jQuery
$(document).on "click", ".btn", (e) -> console.log "Clicked"

# Zest
$ document
  .listen "click"
  .within ".btn"
  .apply (e) -> console.log "Clicked"

```

### Attributes & Data: From Methods to Proxies

Instead of `.attr()` and `.data()` methods, Zest projects the collection into a **Proxy** that acts like a standard object.

**Recipe: Reading and Writing Data**

```coffeescript
# jQuery
userId = $el.data "id"
$el.attr "title", "User Profile"

# Zest
userId = $el.data.id
$el.attributes.title = "User Profile"

```

### Forms: Direct Data Extraction

Zest simplifies form handling by utilizing the native `FormData` API through the `.form` projection.

**Recipe: Get Form Values**

```coffeescript
# jQuery
values = $("form").serializeArray()

# Zest
values = $("form").form.data

```

### Content & Rendering

Zest moves away from jQuery's string-heavy manipulation toward native node handling and the `@dashkite/flashdom` declarative renderer.

| Task | jQuery | Zest |
| --- | --- | --- |
| **Get HTML** | `$el.html()` | `$el.html` |
| **Set HTML** | `$el.html("<b>Hi</b>")` | `$el.html = "<b>Hi</b>"` |
| **Empty** | `$el.empty()` | `$el.html = ""` |
| **Append Node** | `$el.append(node)` | `$el.html = node` |

---

## Common Recipes

### Watching for Visibility

Instead of manually calculating scroll offsets or using a heavy plugin, Zest uses a native `IntersectionObserver` wrapper.

```coffeescript
# Trigger logic when an element enters the viewport
$ ".lazy-image"
  .show (el) -> 
    $(el).attributes.src = $(el).data.src

```

### Scoped Property Updates

You can update properties across an entire collection using the `properties` proxy. This is more performant than manual iteration for simple DOM properties.

```coffeescript
# Disable all buttons in a container
$ ".submit-group button"
  .properties.disabled = true

```

### The "Shadow DOM" Slot Recipe

If you are building Web Components, Zest provides a clean way to find nodes assigned to specific slots.

```coffeescript
# Get all nodes assigned to the "header" slot
headerNodes = $ "my-component"
  .slotted.named "header"

```

## Extending Zest

Extending Zest is done by creating functional mixins that hook into the `@dashkite/joy` metaclass system. This allows you to add domain-specific projections—like a "Gallery" or "Auth" interface—without modifying the core library.

---

## Extending Zest: Custom Mixins

Since Zest uses a **Flat-Type** architecture, adding a feature means defining a mixin and applying it to the base `Zest` class.

### 1. Defining a Projection

A common pattern in Zest is to use a "Handler" class and a Proxy. This keeps your custom methods from clashing with other mixins.

```coffeescript
import { metaclass } from "@dashkite/joy/metaclass"

# The specialized logic
class Gallery extends metaclass()
  @make: (zest) -> 
    Object.assign (new @), { zest }

  next: ->
    # Logic to find next image in a set
    @zest.each (el) -> console.log "Advancing gallery: #{el.id}"

# The mixin function
gallery = (base = metaclass()) ->
  class extends base
    @getters
      gallery: -> Gallery.make @

export { gallery }

```

### 2. Registering the Mixin

To use your new projection, you include it in the `Fn.pipe` chain when defining your custom Zest instance.

```coffeescript
import { Zest } from "@dashkite/zest/zest"
import { gallery } from "./mixins/gallery"

# Create an extended version of Zest
class MyZest extends Fn.pipe([ gallery ]) Zest

# Usage
$ ".photo-hub"
  .gallery.next()

```

---

## Extension Recipes

### The "UI Component" Recipe

If you find yourself repeatedly setting specific ARIA attributes or UI states, you can create a `ui` projection.

```coffeescript
ui = (base = metaclass()) ->
  class extends base
    @getters
      ui: ->
        busy: (state) => @each (el) -> el.setAttribute "aria-busy", state
        hidden: (state) => @each (el) -> el.hidden = state

# Usage
$ ".submit-btn"
  .ui.busy "true"

```

### The "Animate" Recipe

Zest’s categorical nature makes it perfect for triggering CSS transitions across multiple elements simultaneously.

```coffeescript
animate = (base = metaclass()) ->
  class extends base
    fade: (opacity) ->
      @each (el) -> 
        el.style.transition = "opacity 0.5s"
        el.style.opacity = opacity

# Usage
$ ".alert-box"
  .fade 0

```

---

## Internal Architecture Reference

Understanding the relationship between the **Zest Collection**, **Mixins**, and **Proxies** is key to effective extension.

| Layer | Component | Role |
| --- | --- | --- |
| **Interface** | `$` Constructor | Generically dispatches and wraps nodes into a collection. |
| **Logic** | Mixins | Provide the flat methods (like `each`, `map`) and the projection getters. |
| **Projection** | Proxies / Handlers | Isolate specialized domain logic (like `events` or `forms`). |
| **Data** | Categorical List | The underlying array of elements being acted upon. |

**Would you like me to draft a `CONTRIBUTING.md` file based on this architecture to help other developers add mixins to the Zest ecosystem?**