import { metaclass } from "@dashkite/joy/metaclass"

class Form extends metaclass()

  @make: ( zest ) ->
    Object.assign ( new @ ), { zest }

  @getters
    form: ->
      @zest.first?.querySelector "form" 
    data: ->
      # returns {} when !@form?
      Object.fromEntries ( new FormData @form )

  reset: ->
    @form?.reset()

forms = ( base = metaclass()) ->

  class extends base
    @getters
      form: -> Form.make @

export { forms }