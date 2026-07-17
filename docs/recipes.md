# Zest Recipes

These usage guides provide task-based scenarios demonstrating how to solve practical problems with Zest. They follow a narrative arc that moves progressively from foundational interactions to more complex, specialized techniques, providing coverage for all core APIs and projections.

## Constructing Collections

### Task
Query the document for specific DOM nodes and scope a nested search inside them.

### Zest Approach
Zest enables this task by exposing a unified `$` constructor that wraps standard DOM queries, along with scoping methods like `.query` to execute internal searches against a parent collection.

### Example
```coffeescript
import $ from "@dashkite/zest"

# retrieve sub-elements only within the primary container
$ ".primary-container"
  .query ".child-node"
```

### Algorithm
1. Invoke the `$` constructor with a CSS selector to select the parent node.
2. Call the `.query` method to run a nested selector search.
3. Zest automatically flattens and normalizes the results into a new collection.

## Mapping and Filtering Elements

### Task
Extract specific textual values from a subset of elements based on programmatic logic.

### Zest Approach
Zest Collections operate as monads. Using functional combinators like `.filter` and `.map`, a developer can execute transformations seamlessly without resorting to raw `for` loops.

### Example
```coffeescript
import $ from "@dashkite/zest"

# complex external business logic determining visibility
isVisible = ( el ) -> el.checkVisibility()

labels = 
  $ ".widget"
    .filter ( el ) -> isVisible el
    .map ( el ) -> el.innerText
```

### Algorithm
1. Invoke the `$` constructor to select target nodes.
2. Call the `.filter` combinator to cull the collection based on the predicate.
3. Call the `.map` combinator to transform the remaining nodes into an array of strings.

## Managing Classes and Data Attributes

### Task
Store a programmatic identifier on an element and visually mark it as active.

### Zest Approach
Zest uses the `.data` and `.classes` proxy projections. Instead of iterating manually, any changes to these projections propagate instantly to all native elements in the collection.

### Example
```coffeescript
import $ from "@dashkite/zest"

target = $ ".navigation-tab"

# assign the data state and the css class
target.data.set "activeTab", "home"
target.classes.add "is-active"
```

### Algorithm
1. Select the group of elements using the `$` constructor.
2. Access the `.data` projection and invoke `.set` to assign a dataset attribute.
3. Access the `.classes` projection and invoke `.add` to attach a new CSS class.

## Updating Element Properties

### Task
Programmatically disable a set of buttons across the UI.

### Zest Approach
Zest handles this task via the `.properties` projection, which directly writes to underlying DOM properties concurrently.

### Example
```coffeescript
import $ from "@dashkite/zest"

target = $ ".submit-group button"
target.properties.disabled = true
```

### Algorithm
1. Select the elements using the `$` constructor.
2. Access the `.properties` projection.
3. Assign the desired property value, triggering native propagation.

## Processing Form Submissions

### Task
Extract all input values from a form securely into a clean, key-value object upon submission.

### Zest Approach
Zest abstracts this task via the `.form` projection, which internally wraps the native `FormData` API and directly exposes the extracted data payload.

### Example
```coffeescript
import $ from "@dashkite/zest"

# handle external form submission request
processRegistration = ( data ) -> # network request logic

formEl = $ "form#registration"
userData = formEl.form.data

processRegistration userData
```

### Algorithm
1. Wrap the form element in a Zest collection.
2. Access the `.form` proxy projection.
3. Retrieve the `.data` property to yield the mapped object of the form's key-value pairs.

## Handling File Uploads and Previews

### Task
Instantly generate a temporary URL to preview an image file selected by a user before uploading it.

### Zest Approach
The `.files` projection abstracts the native File API, automatically evaluating the first selected file and yielding a secure object URL via `.url`.

### Example
```coffeescript
import $ from "@dashkite/zest"

# render the preview to the UI
renderPreview = ( src ) -> # ui update logic

uploader = $ "#avatar-upload"
previewUrl = uploader.files.url

renderPreview previewUrl if previewUrl
```

### Algorithm
1. Select the file input using the `$` constructor.
2. Access the `.files` projection on the collection.
3. Read the `.url` getter to retrieve the generated `createObjectURL` string.

## Binding Basic Event Listeners

### Task
Execute logic whenever a user clicks a button, without manually iterating over a `NodeList`.

### Zest Approach
Zest defers event compilation using the `.listen` method and the `.apply` finisher. Fluent aliases like `.click()` map to standard DOM events.

### Example
```coffeescript
import $ from "@dashkite/zest"

# trigger analytic events
recordClick = -> # analytics logic

$ ".tracking-btn"
  .listen "click"
  .apply ( e ) -> recordClick()
```

### Algorithm
1. Select the target buttons.
2. Initiate the event pipeline using `.listen`.
3. Terminate the pipeline and attach the listener using `.apply` with the handler function.

## Delegating Events and Preventing Defaults

### Task
Handle click events for dynamically added child elements within a container, while blocking the browser's default link navigation.

### Zest Approach
Zest simplifies delegation via the `.within` filter, restricting the handler to targets matching the selector. The `.prevent` modifier blocks default behaviors.

### Example
```coffeescript
import $ from "@dashkite/zest"

# execute the actual removal logic
deleteTask = ( taskId ) -> # application state logic

$ ".task-container"
  .listen "click"
  .prevent()
  .within ".delete-btn"
  .apply ( e ) -> 
    taskId = $ e.target .data.get "taskId"
    deleteTask taskId
```

### Algorithm
1. Select the persistent parent container using the `$` constructor.
2. Initiate a listener for the "click" event.
3. Chain `.prevent` to halt default navigation.
4. Chain `.within` to establish event delegation logic for specific descendants.
5. Chain `.apply` to attach the compiled handler.

## Filtering Complex Event Streams

### Task
Trigger a special handler only if the user holds the Shift key while triggering the event.

### Zest Approach
Zest allows for granular event validation using the `.filter` constraint within the listener pipeline.

### Example
```coffeescript
import $ from "@dashkite/zest"

# complex logic for a special interaction mode
activateSpecialMode = -> # mode toggle logic

$ ".interactive-canvas"
  .listen "mousemove"
  .filter ( e ) -> e.shiftKey
  .apply ( e ) -> activateSpecialMode()
```

### Algorithm
1. Select the target canvas element.
2. Initiate a listener for the "mousemove" event.
3. Chain `.filter` and provide a predicate evaluating the native event object.
4. Chain `.apply` to compile and attach the final listener.

## Dispatching Custom Events

### Task
Notify the surrounding DOM that a component's internal state has changed, broadcasting a data payload.

### Zest Approach
Zest handles event emission via the `.dispatch` method, effortlessly wrapping the native `CustomEvent` API.

### Example
```coffeescript
import $ from "@dashkite/zest"

$ ".my-component" .dispatch
  name: "state-changed"
  detail: { status: "ready" }
```

### Algorithm
1. Select the component element.
2. Invoke `.dispatch` with an object payload.
3. Zest automatically constructs a `CustomEvent` mapping the `name` and `detail` fields, firing it across all collection elements.

## Triggering Logic on Visibility Changes

### Task
Execute logic exactly when an element enters the visible viewport.

### Zest Approach
Zest abstracts the native `IntersectionObserver` API inside the declarative `.show` method, managing observer connections silently.

### Example
```coffeescript
import $ from "@dashkite/zest"

# complex external fetching mechanism
loadImage = ( url ) -> # fetching logic

$ ".lazy-image"
  .show ( el ) -> 
    imageSource = $ el .data.get "src"
    loadImage imageSource
```

### Algorithm
1. Select the target elements using the `$` constructor.
2. Invoke the `.show` method on the collection.
3. Provide a handler function to execute when an element intersects the viewport.

## Reacting to DOM Mutations

### Task
Execute logic whenever a third-party script modifies a specific data attribute on an element.

### Zest Approach
Zest abstracts `MutationObserver` via the `.modify` projection. Calling `.modify.attributes` binds the observer strictly to the specified attributes.

### Example
```coffeescript
import $ from "@dashkite/zest"

# handle external state update
syncState = ( target ) -> # sync logic

$ ".third-party-widget" .modify.attributes [ "data-status" ], ( target ) ->
  syncState target
```

### Algorithm
1. Select the widget element using the `$` constructor.
2. Access the `.modify` proxy projection.
3. Invoke `.attributes`, passing the array of target attribute names and a handler function.

## Inspecting Web Component Slots

### Task
Iterate over the specific elements that a user assigned to a named slot within a custom Web Component.

### Zest Approach
Zest accesses Shadow DOM assigned nodes smoothly via the `.slotted` projection, separating named slots from anonymous ones automatically.

### Example
```coffeescript
import $ from "@dashkite/zest"

# process projected nodes
configureHeader = ( nodes ) -> # shadow dom logic

$ "my-layout"
  .slotted.named "header"
  .forEach ( node ) -> configureHeader node
```

### Algorithm
1. Select the custom web component.
2. Access the `.slotted` proxy projection.
3. Invoke `.named` to yield an array of nodes inserted into the target slot.

## Synchronizing State with Flash DOM

### Task
Completely update the internal content of a container based on newly fetched HTML without losing focus or scroll state on unaffected nodes.

### Zest Approach
Zest achieves this task by integrating with Flash DOM via the `.render` method, applying incremental memory flashing instead of destructive replacement.

### Example
```coffeescript
import $ from "@dashkite/zest"

# retrieve new content from an API
fetchUpdates = -> # network logic returning an HTML string

updateUI = ( htmlString ) ->
  $ "#dashboard-panel" .render htmlString
```

### Algorithm
1. Retrieve the new HTML content representing the future state.
2. Select the target container using the `$` constructor.
3. Invoke the `.render` method on the collection, passing the HTML string.
4. Allow Zest and Flash DOM to compute differences and patch the DOM efficiently in place.
