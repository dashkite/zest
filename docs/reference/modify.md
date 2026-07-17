# Modify Projection Reference

This document provides a detailed reference for the Zest `Modify` projection, which simplifies declarative DOM mutation observation across collections of elements.

## Understanding the Modify Projection

Tracking when elements change dynamically—such as when attributes are updated or when children are added/removed—normally requires manually instantiating a `MutationObserver`, configuring observation options, managing the connection lifecycle, and iterating over mutation records.

The `Modify` projection in Zest abstracts all of this complexity. By accessing the `.modify` proxy on a Zest collection, you receive an instance of the `Modify` class. Calling its methods automatically spins up internal `MutationObserver` instances configured with the correct flags (like `childList` or `subtree`) and binds them to every element in the collection. The handlers you provide are invoked directly with the target element whenever a matching mutation occurs.

## Modify

The core class representing the mutation observer projection. It is instantiated automatically and accessed via the `.modify` getter on a Zest collection.

### attributes:

$attributes: names, handler \to \emptyset$

Configures a mutation observer to track changes to specific attributes on all elements in the collection. It takes an array of attribute `names` to filter the observation and a `handler` function that receives the mutated target element.

```coffeescript
import assert from "@dashkite/assert"
import $ from "@dashkite/zest"

# Observe changes to the 'data-state' attribute
$ ".tracked-element" .modify.attributes [ "data-state" ], ( target ) ->
  assert target.hasAttribute "data-state"
  console.log "State changed on", target
```

### children:

$children: handler \to \emptyset$

Configures a mutation observer to track the addition or removal of direct child nodes on all elements in the collection (setting the `childList: true` configuration internally). The `handler` is triggered with the target element whenever its immediate children mutate.

```coffeescript
import assert from "@dashkite/assert"
import $ from "@dashkite/zest"

$ "#task-list" .modify.children ( target ) ->
  assert target.tagName == "UL"
  console.log "Task list was updated."
```

### descendents:

$descendents: handler \to \emptyset$

Configures a mutation observer to track the addition or removal of descendent nodes throughout the entire subtree of all elements in the collection (setting both `childList: true` and `subtree: true` internally). The `handler` is triggered with the target element that experienced the mutation.

```coffeescript
import assert from "@dashkite/assert"
import $ from "@dashkite/zest"

$ ".container" .modify.descendents ( target ) ->
  assert target.classList.contains "container"
  console.log "The container's subtree was mutated."
```
