# Listener Projection Reference

This document provides a detailed reference for the Zest `Listener` handler, which enables the declarative composition and delegation of DOM events.

## Understanding the Listener Projection

Standard DOM event handling typically requires attaching multiple distinct listeners, manually managing event propagation (`stopPropagation`), preventing defaults (`preventDefault`), and writing conditional logic to handle event delegation.

The `Listener` projection in Zest abstracts this process by deferring the actual listener attachment. When you invoke `.listen()` on a Zest collection, it yields a `Listener` object. You can then chain constraint modifiers—such as `.within()` for delegation or `.prevent()` to block default behavior. Only when you call `.apply()` does Zest compile these constraints into a single, highly efficient native event listener and attach it to the underlying DOM elements.

## Listener

The core handler class representing an event configuration pipeline. It is instantiated automatically and accessed via the `.listen()` method on a Zest collection.

### listen:

$listen: event \to Listener$

Initiates or adds a native DOM event type to the current listener configuration. This allows a single handler to respond to multiple event types. Zest also provides fluent alias methods for common events (e.g., `.click()`, `.submit()`, `.keydown()`) directly on the `Listener` object.

```coffeescript
import $ from "@dashkite/zest"

# Listen to both focus and blur using fluent aliases
$ ".input-field"
  .listen "focus"
  .blur()
  .apply ( e ) -> console.log "Input state changed."
```

### capture:

$capture: \to Listener$

Instructs the event configuration to use the capture phase rather than the bubbling phase when attaching the final native listener.

### stop:

$stop: \to Listener$

Instructs the listener pipeline to automatically call `event.stopPropagation()` when the event fires, preventing it from bubbling up the DOM tree.

### prevent:

$prevent: \to Listener$

Instructs the listener pipeline to automatically call `event.preventDefault()` when the event fires, blocking the browser's default behavior.

```coffeescript
import $ from "@dashkite/zest"

$ "form"
  .listen "submit"
  .prevent()
  .apply ( e ) -> console.log "Form submission halted."
```

### intercept:

$intercept: \to Listener$

A convenience method that instructs the listener pipeline to both stop event propagation and prevent the default browser behavior simultaneously.

### matches:

$matches: selector \to Listener$

Filters the event stream. The final handler will only trigger if the element that precisely originated the event (`event.target`) matches the provided CSS selector.

### within:

$within: selector \to Listener$

Filters the event stream for event delegation. The final handler will only trigger if the element originating the event, or one of its ancestors, matches the provided CSS selector.

```coffeescript
import $ from "@dashkite/zest"

# Delegate click events within a list
$ "#task-list"
  .listen "click"
  .within ".delete-btn"
  .apply ( e ) -> console.log "Delete button clicked."
```

### filter:

$filter: predicate \to Listener$

Filters the event stream using a custom predicate function. The final handler will only trigger if the predicate function returns a truthy value when evaluated against the native event object.

```coffeescript
import $ from "@dashkite/zest"

# Only trigger if the Shift key was held during the click
$ ".special-btn"
  .listen "click"
  .filter ( e ) -> e.shiftKey
  .apply ( e ) -> console.log "Shift-click detected."
```

### apply:

$apply: handler \to \emptyset$

Finalizes the event configuration pipeline. It compiles all chained constraints (filters, modifiers) and the final handler function into a single execution block, then attaches this compiled listener to every native element in the Zest collection.

```coffeescript
import $ from "@dashkite/zest"

$ ".container"
  .listen "click"
  .prevent()
  .within ".nav-link"
  .apply ( e ) -> console.log "Navigation intercepted."
```
