import { metaclass } from "@dashkite/joy/metaclass"

class Slotted

  @make: ( zest ) -> 
    Object.assign ( new @ ), { zest }

  named: ( name ) ->
    @zest.map ( element ) ->
      element
        .querySelector "slot[name='#{ name }']"
        .assignedNodes()
  
  anonymous: ->
    @zest.map ( element ) ->
      element
        .querySelector "slot:not([name])"
        .assignedNodes()

  all: ->
    @zest.map ( element ) ->
      element
        .querySelector "slot"
        .assignedNodes()


slots = ( base = metaclass()) ->

  class extends base

    @getters
      slots: ->
        if ( element = @first )?
          result = {}
          for element from element.querySelectorAll "[slot]"
            result[ element.slot ] = element
          result
        else {}

      slotted: -> Slotted.make @

      

export { slots }