import * as Meta from "@dashkite/joy/metaclass"

metaclass = ( base = Object ) ->

  class extends base

    @properties: ( dictionary ) ->
      Meta.properties dictionary, @::

export default metaclass
export { metaclass }