import { metaclass } from "@dashkite/joy/metaclass"

###

    TODO Add size and position properties

    This is somewhat complex, since the DOM has several measures
    for size and position, depending on whether you want to include
    margins, passing, scrollbars, and so on.

###


dimensions = ( base = metaclass()) ->

  class extends base

export { dimensions }