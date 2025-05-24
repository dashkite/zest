import { metaclass } from "@dashkite/joy/metaclass"

# TODO traversals

navigators = ( base = metaclass()) ->

  class extends base

    @getters

      next: ->
        @map ( element ) -> element.nextSibling

      previous: ->
        @map ( element ) -> element.previousSibling

      parent: ->
        @map ( element ) -> element.parentNode

      children: ->
        if @first?
          @constructor.make @first.childNodes
        else
          @construct.make()

    closest: ( selector ) ->
      @map ( element ) ->
        element.closest selector

export { navigators }
