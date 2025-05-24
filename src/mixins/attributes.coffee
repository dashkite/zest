import { metaclass } from "@dashkite/joy/metaclass"
import Handler from "#helpers/data-handler"

class Attributes extends metaclass()

  @make: ( zest ) ->
    Object.assign ( new @ ), { zest }

  @getters

    keys: ->
      if !@zest.first?
        []
      else
        Array
          .from @zest.first.attributes
          .map ({ name }) -> name

    data: ->
      if !@zest.first?
        {}
      else
        Object.fromEntries do ->
          Array
            .from @zest.first.attributes
            .map ({ name, value }) -> [ name, value ]
      
  has: ( name ) ->
    @zest.first?.hasAttribute name

  get: ( name ) ->
    @zest.first?.getAttribute name

  set: ( name, value ) ->
    @zest.each ( element ) ->
      element.setAttribute name, value

  remove: ( name ) ->
    @zest.each ( element ) ->
      element.removeAttribute name

attributes = ( base = metaclass()) ->

  class extends base

    @getters
      attributes: -> 
        new Proxy ( Attributes.make @ ), Handler

export { attributes }