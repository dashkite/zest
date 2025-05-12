import { metaclass } from "./metaclass"

class Classes

  @make: ( zest ) ->
    Object.assign ( new @ ), { zest }

  add: ( name ) ->
    @zest.each ( element ) ->
      element.classList.add name
  
  remove: ( name ) -> 
    @zest.each ( element ) ->
      element.classList.remove name

  toggle: ( name ) -> 
    @zest.each ( element ) ->
      element.classList.toggle name

  replace: ( current, replacement ) -> 
    @zest.each ( element ) ->
      element.classList.replace current, replacement

  contains: ( name ) -> 
    @zest.first? && @zest.first.classList.contains name

classes = ( base = metaclass()) ->

  class extends base

    @properties 

      classes:
        get: -> Class.make @

export { classes }