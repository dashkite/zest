import { metaclass } from "./metaclass"
import Handler from "#helpers/data-handler"

class DataSet

  @make: ( zest ) ->
    Object.assign ( new @ ), { zest }

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

  keys: ->
    if !@first?
      []
    else
      Object.keys @first.dataset

  data: ->
    if !@first?
      {}
    else
      { @first.dataset... }
  
data = ( base = metaclass()) ->

  class extends base

    @properties

      dataset:
        get: -> @first?.dataset

      data:
        get: -> 
          new Proxy ( DataSet.make @ ), Handler




export { data }