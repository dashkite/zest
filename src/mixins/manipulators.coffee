import { flash } from "@dashkite/flashdom"
import { metaclass } from "./metaclass"

###

    TODO Support explicit DOM updates
    
    I'm not entirely sure about all of these methods
    but it's starting point. h/t JQuery

    after
    append
    appendTo
    before
    clone
    empty
    insertAfter
    insertBefore
    prepend
    prependTo
    remove
    replaceAll
    replaceWith
    unwrap
    wrap
    wrapAll
    wrapInner

###

manipulators = ( base = metaclass()) ->

  class extends base

    @properties
      html:
        get: -> @first?.innerHTML
        set: ( value ) ->
          @each ( element ) ->
            element.innerHTML = value

    render: ( value ) ->
      @each ( element ) ->
        flash element, value

export { manipulators }

