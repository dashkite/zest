import { metaclass } from "./metaclass"

class Form extends metaclass()

  @make: ( zest ) ->
    Object.assign ( new @ ), { zest }

  @properties
    data:
      get: ->
        if @zest.first?
          Object.fromEntries ( new FormData @element )
        else {}

  reset: ->
    @zest.first?.reset?()

forms = ( base = metaclass()) ->

  class extends base
    @properties
      form:
        get: ->
          Form.make @

export { forms }