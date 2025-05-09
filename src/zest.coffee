import Arr from "#helpers/array"
import { property } from "./helpers/metaclass"
import { 
  metaclass, attributes
  classes, data, properties
  events, selectors, manipulators
  navigators, forms, dimension
} from "./mixins"

#
# - event methods (stop, intercept, etc.)
#

class Zest extends do Fn.pipe [
    metaclass, attributes
    classes, data, properties
    events, selectors, manipulators
    navigators, forms, dimension
  ]

  @make: do ->

    Generic.make "DOM.List"

      .define [], -> @make []
      
      .define [ Type.isIterable ], ( it ) ->
        Object.assign ( new @ ), 
          elements: Arr.uniqueAndCompact Array.from it

      .define [ Type.isGenerator ], ( g ) -> @make g()

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
    elements = @elements
    @constructor.make -> 
      ( yield f e ) for e in elements
      return

  each: ( f ) ->
    ( f e ) for e in @elements
    @

  @properties

    first: 
      get: -> @elements[ 0 ]



export { Zest }
export default Zest