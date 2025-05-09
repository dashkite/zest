###

  TODO Add selector filters
  
  Matches could potentially (also) be a filter

###

selectors = ( base = Object ) ->

  class extends base

    matches: ( selector ) ->
      if @first?
        @first.matches selector
      else false

export { selectors }