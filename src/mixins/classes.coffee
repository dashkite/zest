import { metaclass } from "@dashkite/joy/metaclass"

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
    @zest.filter ( element ) ->
      element.classList.contains name

classes = ( base = metaclass()) ->

  class extends base

    @getters 
      classes: -> Classes.make @

export { classes }