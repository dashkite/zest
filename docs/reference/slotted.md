# Slotted Projection Reference

This document provides a detailed reference for the Zest `Slotted` projection, which simplifies interactions with the Web Component slot API.

## Understanding the Slotted Projection

When building Web Components using the Shadow DOM, developers often need to inspect or manipulate the nodes that a consumer has inserted into the component's `<slot>` elements. Doing this manually involves querying the shadow root for the specific slot and then calling the native `assignedNodes()` method.

The `Slotted` projection in Zest streamlines this workflow. By accessing the `.slotted` proxy on a Zest collection that wraps a custom element, you receive an instance of the `Slotted` class. This projection allows you to declaratively retrieve arrays of assigned nodes based on whether the slot is named, anonymous (default), or regardless of its type.

## Slotted

The core class representing the slotted node projection. It is instantiated automatically and accessed via the `.slotted` getter on a Zest collection.

### named:

$named: name \to array$

Retrieves all nodes that have been assigned to a specifically named slot within the first native element of the collection.

```coffeescript
import assert from "@dashkite/assert"
import $ from "@dashkite/zest"

# Assuming <my-layout> contains <slot name="header"></slot>
target = $ "my-layout"
headerNodes = target.slotted.named "header"

assert Array.isArray headerNodes
```

### anonymous:

$anonymous: \to array$

Retrieves all nodes that have been assigned to the default, unnamed (anonymous) slot within the first native element of the collection.

```coffeescript
import assert from "@dashkite/assert"
import $ from "@dashkite/zest"

# Assuming <my-card> contains a default <slot></slot>
target = $ "my-card"
defaultNodes = target.slotted.anonymous()

assert Array.isArray defaultNodes
```

### all:

$all: \to array$

Retrieves all assigned nodes across every slot (both named and anonymous) within the first native element of the collection, combining them into a single array.

```coffeescript
import assert from "@dashkite/assert"
import $ from "@dashkite/zest"

target = $ "my-card"
allSlottedNodes = target.slotted.all()

assert Array.isArray allSlottedNodes
```
