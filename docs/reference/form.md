# Form Projection Reference

This document provides a detailed reference for the Zest `Form` projection, which simplifies common interactions and data extraction for HTML form elements.

## Understanding the Form Projection

Working with forms in vanilla JavaScript often requires instantiating `FormData` objects and converting them into more usable plain objects before transmission or validation. 

The `Form` projection in Zest abstracts this process. By accessing the `.form` proxy on a Zest collection that wraps a `<form>` element, you receive an instance of the `Form` class. This projection instantly converts form fields into a key-value object and provides direct access to native form manipulation methods, such as resetting the form state.

## Form

The core class representing the form utilities projection. It is instantiated automatically and accessed via the `.form` getter on a Zest collection.

### data

$data \to object$

A property getter that automatically constructs a native `FormData` instance from the first form element in the collection and converts it into a plain JavaScript key-value object. This is highly useful for extracting user input securely and cleanly. If the collection is empty, it returns an empty object.

```coffeescript
import assert from "@dashkite/assert"
import $ from "@dashkite/zest"

# Assuming the form has inputs for 'username' and 'email'
userData = $ "#profile-form" .form.data

assert typeof userData == "object"
# assert userData.username == "testuser"
```

### reset:

$reset: \to \emptyset$

Calls the native `.reset()` method on the first form element in the collection, restoring all input fields within the form to their default initial states.

```coffeescript
import $ from "@dashkite/zest"

targetForm = $ "#profile-form"

# Clear all user input and restore defaults
targetForm.form.reset()
```
