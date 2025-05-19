import { metaclass } from "./metaclass"

class Form extends metaclass()

  @make: ( zest ) ->
    Object.assign ( new @ ), { zest }

  @properties
    form:
      get: ->
        @zest.first?.querySelector "form" 
    data:
      get: ->
        # returns {} when !@form?
        Object.fromEntries ( new FormData @form )

  reset: ->
    @form?.reset()

forms = ( base = metaclass()) ->

  class extends base
    @properties
      form:
        get: ->
          Form.make @

export { forms }