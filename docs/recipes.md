# Zest Recipes

Task-based scenarios and common patterns for working with the Zest DOM monad.

## Event Delegation

### Task
Handle click events for dynamically added buttons within a container without rebinding listeners for each new element.

### Zest Approach
Use the `.listen` projection with the `.within` filter to delegate events to a parent container.

### Example
```coffeescript
$ ".container"
  .listen "click"
  .within ".dynamic-btn"
  .apply ( e ) -> console.log "Clicked dynamic button"
```

### Algorithm
1.  Select the parent container using `$`.
2.  Initiate a listener for the "click" event using `.listen`.
3.  Specify the target child selector using `.within`.
4.  Apply the final handler using `.apply`.

## Visibility Monitoring (Lazy Loading)

### Task
Trigger an action only when an element enters the visible viewport (e.g., for lazy-loading images).

### Zest Approach
Use the built-in `.show` observer to wrap the native `IntersectionObserver` API.

### Example
```coffeescript
$ ".lazy-image"
  .show ( el ) -> 
    $( el )
      .attributes.src = $( el ).data.src
```

### Algorithm
1.  Select the targets using `$`.
2.  Provide a handler function to the `.show` method.
3.  In the handler, update the source attribute using the `.attributes` and `.data` proxies.

## Form Data Extraction

### Task
Retrieve all values from a form as a clean, key-value object.

### Zest Approach
Utilize the `.form` projection to interact with the native `FormData` API.

### Example
```coffeescript
userData = $ "form#user-profile" .form.data
```

### Algorithm
1.  Select the form element.
2.  Access the `.form` projection.
3.  Retrieve the `.data` property.

## Bulk Property Updates

### Task
Update a DOM property (like `disabled` or `checked`) across multiple elements simultaneously.

### Zest Approach
Use the `.properties` proxy to write directly to the underlying DOM properties for every element in the collection.

### Example
```coffeescript
# Disable all submit buttons
$ ".submit-group button"
  .properties.disabled = true
```

### Algorithm
1.  Select the group of elements.
2.  Access the `.properties` proxy.
3.  Set the desired property value directly.
