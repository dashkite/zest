import { metaclass } from "./metaclass"
import Handler from "#helpers/data-handler"

properties = ( base = metaclass()) ->

  class extends base

    @property

      id:
        get: -> @first?.id
        set: ( value ) ->
          @each ( element ) ->
            element.id = value

      name:
        get: -> @first?.name
        set: ( value ) ->
          @each ( element ) ->
            element.name = value

      value:
        get: -> @first?.value
        set: ( value ) ->
          @each ( element ) ->
            element.value = value

      properties:
        get: ->
          new Proxy @first,
            set: ( _, name, value ) =>
              @each ( element ) ->
                element[ name ] = value

export { properties }