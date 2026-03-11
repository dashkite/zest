
filters = ( base = Object ) ->

  class extends base

    matches: ( selector ) ->
      @filter ( element ) ->
        element.matches ( selector )

export { filters }
