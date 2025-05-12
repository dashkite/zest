# DashKite Zest

*DOM List Monad*

[![Hippocratic License HL3-CORE](https://img.shields.io/static/v1?label=Hippocratic%20License&message=HL3-CORE&labelColor=5e2751&color=bc8c3d)](https://firstdonoharm.dev/version/3/0/core.html)

Inspired by JQuery, Zest provides a monadic interface for interacting with the DOM.

## Usage

### Examples

Event listener:

```coffeescript
import $ from "@dashkite/zest"

await $.ready

$ "button"
	.listen()
  .click()
  .intercept()
  .apply -> console.log "button clicked!"
```

Diff-based update:

```coffeescript
$ "heading"
	.render "<h1>Hello, World</h1>"
```

## API

### Constructors

#### Node

Constructs a unitary Zest with the given element.

#### HTML

Parses the HTML and constructs a Zest with the resulting NodeLIst.

#### Selector

Selects the given elements and constructs a Zest. Takes an optional root element.

#### Iterable

Constructs a Zest with the Nodes produced by the iterable.

#### Generator

Constructs a Zest with the Nodes produced by the generator.

#### Event

Constructs a unitary Zest based on the event target, if any, otherwise constructs an empty Zest.

#### Nullish

Constructs an empty Zest.

### Elements

#### each

#### elements

Returns the elements of the Zest object as an array.

#### filter

#### first

Returns the first element of the Zest object or undefined.

#### last

Returns the last element of the Zest object or undefined.

#### map

Given: a function that takes and returns an DOM node, `map` applies the function to each Zest element, and returns a new Zest containing the results.

### Accessors

#### attributes

The `attributes` property returns a proxy for an [Attributes](#attributes) object bound to the Zest.

From there, you can manipulate the attributes of the Zest elements.

##### Example

```coffeescript
$ "button"
	.attributes
  .get "name"
```

#### classes

The `classes` property returns a [Classes](#attributes) object bound to the Zest.

From there, you can manipulate the `class` attribute of the Zest elements.

##### Example

```coffeescript
$ "button"
	.classes
  .toggle "default"
```

#### data

The `data` property returns a proxy for a [DataSet](#dataset) object bound to the Zest.

From there, you can manipulate the dataset properties of the Zest elements.

#### dataset

The `dataset` property returns the DOM dataset property of the first element in the Zest.

#### form

The `form` property returns a [Form](#form) object bound to the Zest.

From there, you can access the form data properties of the Zest elements.

#### id

The `id` property returns the DOM dataset property of the first element in the Zest.

#### html

#### name

#### properties

#### text

#### value

### Events

#### listen
#### dispatch

#### blur

#### click

#### focus
### Navigation

#### closest

### Updates

#### render

### Observation

#### show

#### hide

#### modify

### Filters

#### matches

### Attributes

#### has

#### get

#### set

#### remove

#### keys

#### data

### Classes

### Form

### Listener

### Modify

### Properties
