# DataSet Projection Reference

This document provides a detailed reference for the Zest `DataSet` projection, which simplifies the interaction with custom data attributes (`data-*`) across a collection of DOM elements.

## Understanding the DataSet Projection

Native DOM scripting requires interacting with the `dataset` property on individual elements, which can become tedious when modifying state across multiple elements simultaneously. 

The `DataSet` projection in Zest abstracts this process. By accessing the `.data` proxy on a Zest collection, you receive an instance of the `DataSet` class. Method calls like `set` and `remove` automatically iterate over every element in the Zest collection and update their native `dataset` objects in place. For read operations, such as `get` or `has`, the projection consistently interrogates the first element in the collection.

## DataSet

The core class representing the data attribute projection. It is instantiated automatically and accessed via the `.data` getter on a Zest collection.

### keys

$keys \to array$

A property getter that returns an array of strings representing all the data attribute keys present on the first native element in the collection. Returns an empty array if no elements exist or no data attributes are defined.

```coffeescript
import assert from "@dashkite/assert"
import $ from "@dashkite/zest"

# Set a data attribute
$ ".item" .data.set "userId", "123"

# Retrieve the keys
keys = $ ".item" .data.keys
assert keys.includes "userId"
```

### data

$data \to object$

A property getter that returns the full `dataset` of the first native element in the collection as a standard JavaScript object (a shallow clone of the DOMStringMap).

```coffeescript
import assert from "@dashkite/assert"
import $ from "@dashkite/zest"

$ ".item" .data.set "role", "admin"

datasetObj = $ ".item" .data.data
assert datasetObj.role == "admin"
```

### get:

$get: name \to value$

Retrieves the string value of the specified data attribute from the first native element in the collection. Returns `undefined` if the element or the attribute does not exist.

```coffeescript
import assert from "@dashkite/assert"
import $ from "@dashkite/zest"

$ ".item" .data.set "status", "active"

value = $ ".item" .data.get "status"
assert value == "active"
```

### has:

$has: name \to boolean$

Checks if the first native element in the collection contains the specified data attribute. Returns `true` if the attribute exists, otherwise `false`.

```coffeescript
import assert from "@dashkite/assert"
import $ from "@dashkite/zest"

target = $ ".item"
target.data.set "processed", "true"

assert target.data.has "processed"
assert !(target.data.has "nonexistent")
```

### set:

$set: name, value \to \emptyset$

Sets the specified data attribute to the provided string value on all native elements in the collection simultaneously. The provided value is automatically converted to a string by the native DOM API.

```coffeescript
import assert from "@dashkite/assert"
import $ from "@dashkite/zest"

# Update state across multiple elements
$ ".card" .data.set "selected", "true"

# Verify on the first element
assert $ ".card" .first.dataset.selected == "true"
```

### remove:

$remove: name \to \emptyset$

Deletes the specified data attribute from all native elements in the collection simultaneously. This action safely ignores elements that do not possess the attribute.

```coffeescript
import assert from "@dashkite/assert"
import $ from "@dashkite/zest"

target = $ ".card"
target.data.set "temporary", "data"

# Remove the data attribute
target.data.remove "temporary"

assert !(target.data.has "temporary")
```
