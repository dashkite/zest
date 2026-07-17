# Classes Projection Reference

This document provides a detailed reference for the Zest `Classes` projection, which simplifies declarative class manipulation across collections of DOM elements.

## Understanding the Classes Projection

Standard DOM scripting requires developers to manually iterate over arrays or `NodeList` collections to add or remove classes using the `classList` API. The `Classes` projection in Zest abstracts this boilerplate entirely.

When you access the `.classes` proxy on a Zest collection, you receive an instance of the `Classes` class. Any method called on this projection automatically propagates to every underlying native element in the collection simultaneously. Additionally, the `contains` method leverages this architecture to act as a filter, narrowing down the collection rather than returning a simple boolean. 

## Classes

The core class representing the `classList` projection. It is instantiated automatically and accessed via the `.classes` getter on a Zest collection.

### add:

$add: name \to \emptyset$

Adds the specified CSS class name to all native elements within the Zest collection. If the class is already present on an element, the native `classList` safely ignores the addition, ensuring idempotent behavior.

```coffeescript
import assert from "@dashkite/assert"
import $ from "@dashkite/zest"

# Add the 'active' class to all items
$ ".item" .classes.add "active"

assert $ ".item" .first.classList.contains "active"
```

### remove:

$remove: name \to \emptyset$

Removes the specified CSS class name from all native elements within the Zest collection. Like addition, this operation is idempotent and will not throw an error if the class does not exist on the target elements.

```coffeescript
import assert from "@dashkite/assert"
import $ from "@dashkite/zest"

# Remove the 'active' class from all items
$ ".item" .classes.remove "active"

assert !($ ".item" .first.classList.contains "active")
```

### toggle:

$toggle: name \to \emptyset$

Toggles the specified CSS class name on all native elements in the collection. If the class is present on a given element, it is removed; if it is absent, it is added.

```coffeescript
import assert from "@dashkite/assert"
import $ from "@dashkite/zest"

target = $ "#menu"
target.classes.add "open"

# Toggle the state
target.classes.toggle "open"

assert !(target.first.classList.contains "open")
```

### replace:

$replace: current, replacement \to \emptyset$

Replaces an existing CSS class name with a new one across all native elements in the collection. If an element does not possess the `current` class name, no action is taken on that specific element.

```coffeescript
import assert from "@dashkite/assert"
import $ from "@dashkite/zest"

target = $ "#status"
target.classes.add "pending"

# Transition the state
target.classes.replace "pending", "resolved"

assert target.first.classList.contains "resolved"
assert !(target.first.classList.contains "pending")
```

### contains:

$contains: name \to Zest$

Filters the existing Zest collection, returning a new Zest collection that contains only those elements possessing the specified CSS class name. Note that this method returns a collection rather than a boolean, enabling further chaining.

```coffeescript
import assert from "@dashkite/assert"
import $ from "@dashkite/zest"

# Filter down to only active elements
activeElements = $ ".item" .classes.contains "active"

assert activeElements.constructor.name == "Zest"
```
