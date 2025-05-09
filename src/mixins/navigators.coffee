import { metaclass } from "./metaclass"

# TODO traversals

navigators = ( base = metaclass()) ->

  class extends base

    @properties

      next:
        get: ->
          @map ( element ) -> @element.nextSibling

      previous:
        get: ->
          @map ( element ) -> @element.previousSibling

      parent:
        get: ->
          @map ( element ) -> @element.parentNode

      children:
        get: ->
          if @first?
            @constructor.make @first.childNodes
          else
            @construct.make()

    closest: ( selector ) ->
      @map ( element ) ->
        element.closest selector

export { navigators }
