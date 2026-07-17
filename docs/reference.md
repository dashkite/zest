# Zest API Reference

This document serves as the hub for the Zest library API reference. Zest collections present a unified, chainable interface across a large set of domains using a modular mixin architecture. To avoid polluting the core `Zest` collection namespace with hundreds of specific methods, Zest relies on **Projections** and **Proxies**.

- **Projections** return specialized handler objects. For example, accessing `.form` returns a `Form` projection object focused strictly on forms, while `.modify` returns an interface for configuring mutation observers.
- **Proxies** offer direct, object-like access to underlying DOM APIs. For instance, `.properties` allows you to set arbitrary properties directly on elements in the collection seamlessly.

## Reference Modules

The API is divided into the following modules based on their underlying classes and projections:

- [The $ Constructor](./reference/constructor.md): The primary entry point for creating collections.
- [Zest](./reference/zest.md): The core monadic collection and its generic methods.
- [Classes](./reference/classes.md): The `Classes` projection for managing CSS classes.
- [DataSet](./reference/dataset.md): The `DataSet` projection for managing data attributes.
- [Form](./reference/form.md): The `Form` projection for extracting form data.
- [Modify](./reference/modify.md): The `Modify` projection for declarative DOM mutation observation.
- [Files](./reference/files.md): The `Files` projection for handling file inputs.
- [Slotted](./reference/slotted.md): The `Slotted` projection for interacting with Web Component slots.
- [Listener](./reference/listener.md): The `Listener` handler for declarative event composition.
