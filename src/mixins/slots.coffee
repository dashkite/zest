import { metaclass } from "./metaclass"

slots = ( base = metaclass()) ->

  class extends base

    @properties
      slots:
        get: ->
          if ( element = @first )?
            result = {}
            for element from element.querySelectorAll "[slot]"
              result[ element.slot ] = element
            result
          else {}

export { slots }