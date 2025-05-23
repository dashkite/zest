import * as Fn from "@dashkite/joy/function"
import Generic from "@dashkite/generic"
import * as Type from "@dashkite/joy/type"
import Arr from "#helpers/array"

import { 
  metaclass, attributes, classes,
  data, properties, events, filters, 
  manipulators, navigators, forms, 
  dimensions, files, observers, slots
} from "./mixins"

class Zest extends do Fn.pipe [
    metaclass, attributes, classes,
    data, properties, events, filters, 
    manipulators, navigators, forms, 
    dimensions, files, observers, slots
  ]

  @make: do ->

    Generic.make "Zest.make"

      .define [], -> @make []
      
      .define [ Type.isIterable ], ( it ) ->
        Object.assign ( new @ ), 
          elements: Arr.uniqueAndCompact Array.from it

      .define [ Type.isGeneratorFunction ], ( g ) -> @make g()

  @ready: do ->
    isReady = -> document.readyState == "interactive"
    new Promise ( resolve ) ->
      if isReady()
        resolve()
      else
        document.onreadystatechange ->
          if isReady()
            resolve() 

  [ Symbol.iterator ]: -> 
      elements = @elements
      do -> ( yield e ) for e in elements

  map: ( f ) ->
    @constructor.make @elements.map f

  filter: ( f ) ->
    @constructor.make @elements.filter f

  # slice?

  each: ( f ) ->
    ( f e ) for e in @elements
    @

  at: ( n ) -> @elements.at n
  
  @properties

    first:
      get: -> @at 0

    last:
      get: -> @at -1

export { Zest }
export default Zest