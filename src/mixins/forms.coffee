import { metaclass } from "@dashkite/joy/metaclass"

class Form extends metaclass()

  @make: ( zest ) ->
    form = if zest.first instanceof HTMLFormElement
      zest.first
    else
      ( zest.query "form" ).first
      
    Object.assign ( new @ ), { form }

  @getters

    data: ->
      # returns {} when !@form?
      Object.fromEntries ( new FormData @form )

  reset: -> @form?.reset()

forms = ( base = metaclass()) ->

  class extends base
    @getters
      form: -> Form.make @

export { forms }