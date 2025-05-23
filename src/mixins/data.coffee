import { metaclass } from "./metaclass"
import Handler from "#helpers/data-handler"

class DataSet extends metaclass()

  @make: ( zest ) ->
    Object.assign ( new @ ), { zest }

  @properties
    keys:
      get: ->
        if !@zest.first?
          []
        else
          Object.keys @zest.first.dataset

    data: 
      get: ->
        if !@zest.first?
          {}
        else
          { @zest.first.dataset... }
    
  get: ( name ) ->
    @zest.first?.dataset[ name ]
  
  has: ( name ) ->
    name in @zest.first?.dataset

  set: ( name, value ) ->
    @zest.each ( element ) ->
      element.dataset[ name ] = value

  remove: ( name ) ->
    @zest.each ( element ) ->
      delete element.dataset[ name ]

data = ( base = metaclass()) ->

  class extends base

    @properties

      dataset:
        get: -> @first?.dataset

      data:
        get: -> 
          new Proxy ( DataSet.make @ ), Handler

export { data }