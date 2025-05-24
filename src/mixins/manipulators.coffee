import Generic from "@dashkite/generic"
import { flash } from "@dashkite/flashdom"
import { metaclass } from "@dashkite/joy/metaclass"

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
        set: do ->

          ( Generic.make "html" )
          
            .define [ String ], ( value ) ->
              @each ( element ) ->
                element.innerHTML = value

            .define [ Node ], ( node ) ->
              @each ( element ) ->
                element.replaceChildren node

            .define [ NodeList ], ( nodes ) ->
              @each ( element ) ->
                element.replaceChildren nodes...

    render: ( value ) ->
      @each ( element ) ->
        flash element, value

export { manipulators }

