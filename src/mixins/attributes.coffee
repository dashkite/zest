import { metaclass } from "./metaclass"
import Handler from "#helpers/data-handler"

class Attributes

  @make: ( zest ) ->
    Object.assign ( new @ ), { zest }

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

  keys: ->
    if !@first?
      []
    else
      Array
        .from @first.attributes
        .map ({ name }) -> name

  data: ->
    if !@first?
      {}
    else
      Object.fromEntries do ->
        Array
          .from @first.attributes
          .map ({ name, value }) -> [ name, value ]
  

attributes = ( base = metaclass()) ->

  class extends base

    @properties
      attributes:
        get: -> 
          new Proxy ( Attributes.make @ ), Handler


export { attributes }