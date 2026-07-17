# Files Projection Reference

This document provides a detailed reference for the Zest `Files` projection, which simplifies interactions with file input elements.

## Understanding the Files Projection

When dealing with `<input type="file">` elements, standard DOM APIs require you to access the `files` array-like object to retrieve the selected files. Extracting a usable URL for image previews or media rendering often requires boilerplate code involving `URL.createObjectURL`.

The `Files` projection in Zest abstracts this process. By accessing the `.files` proxy on a Zest collection that wraps a file input, you receive an instance of the `Files` class. This projection provides immediate access to high-level utilities, such as securely generating a temporary URL for the first selected file.

## Files

The core class representing the file input projection. It is instantiated automatically and accessed via the `.files` getter on a Zest collection.

### url

$url \to string$

A property getter that generates and returns a temporary DOM string containing a URL representing the first file in the input's file list. This is particularly useful for instantly previewing selected images before uploading them. If no file is selected, it returns `undefined`.

```coffeescript
import assert from "@dashkite/assert"
import $ from "@dashkite/zest"

# Assuming the user selected an image in the file input
target = $ "#avatar-upload"

# Retrieve the preview URL
previewUrl = target.files.url

assert typeof previewUrl == "string"
assert previewUrl.startsWith "blob:"
```
