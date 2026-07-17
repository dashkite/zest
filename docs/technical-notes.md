# Technical Notes

### Categorical Normalization and Chainability

Zest draws inspiration from the chainable, expressive patterns established by libraries like jQuery. By automatically flattening and ensuring uniqueness of elements upon creation, Zest collections are categorically normalized. This ensures that operations like `map` and `filter` do not result in nested or duplicate element sets.

Because Zest functions predictably return a new or modified Zest collection in an idiomatic way, creators can construct deeply chainable and expressive workflows for DOM manipulation. This consistency makes it significantly easier to build higher-level abstractions on top of Zest.

### Smoothing Low-Level DOM APIs

Native DOM APIs contain historic quirks and idiosyncrasies that can make direct manipulation tedious. Zest smooths over these inconsistencies to provide a robust, unified interface across a variety of domains.

- **Data Attribute Manipulation**: Zest proxies the `dataset` API via the `.data` projection, allowing creators to interact with data attributes using standard, consistent object syntax.
- **Event Handling**: The event proxy (accessed via `.listen`) defers the attachment of the actual DOM event listener until the `.apply` method is invoked. This permits creators to declaratively chain filters and modifiers (like `.prevent()` or `.within()`) into a single handler execution path, avoiding multiple distinct listeners and simplifying delegation.
- **Observers**: Zest abstracts native `IntersectionObserver` and `MutationObserver` APIs into intuitive collection methods. The underlying observer instances are managed by the collection, ensuring that they properly disconnect when elements are removed or garbage collected.
- **Collection Operations**: Applying property updates or toggling classes across multiple elements normally requires manual iteration in standard DOM scripting. Zest treats collections as singular targets; setting a value on the `.properties` or `.attributes` projection instantly propagates the change to all underlying elements in the collection without manual looping.

### The Monad

In computer science, a monad is a design pattern used to abstract control flows and state management. Zest applies this pattern to the Document Object Model (DOM). Instead of imperatively interacting with singular elements or manually iterating over `NodeList` collections, a creator interacts with a Zest collection as a singular, iterable object. This abstraction allows developers to apply categorical operations like mapping, filtering, and reduction over a set of elements seamlessly.

External Reference: [Monad (functional programming) on Wikipedia](https://en.wikipedia.org/wiki/Monad_(functional_programming))

### Proxies and Projections

Zest utilizes the native JavaScript `Proxy` object to intercept and redefine fundamental operations for attributes, dataset properties, and events. This pattern allows Zest to present a clean, object-like interface (or a "projection") for complex APIs without deeply nesting method calls.

For instance, the `.attributes` and `.data` properties yield a proxy that automatically translates property assignments into the corresponding `setAttribute` or `dataset` manipulations on the underlying native elements.

External Reference: [Proxy on MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Proxy)

### Functional Composition

Zest embraces the functional composition principles established by the DashKite Joy library. By incorporating a monadic approach, Zest ensures that interactions with the DOM remain functional. When necessary, Zest plays nicely with functional programming styles, treating collections as immutable sources where combinators like `map` or `filter` yield entirely new collections instead of mutating existing arrays.

### Incremental Updates and Synchronization

For advanced DOM manipulation, Zest integrates conceptually with Flash DOM. Flash DOM achieves high performance by applying incremental memory flashing techniques instead of using an intermediate Virtual DOM. While Zest handles the selection, traversal, and event attachment for collections, Flash DOM can be used to synchronize programmatic states onto these nodes efficiently.
