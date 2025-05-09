import * as Meta from "@dashkite/joy/metaclass"

metaclass = ( base = Object ) ->

  class extends base

    @property: ( name, specifier ) ->
      Meta.property name, specifier, @::

export { metaclass }