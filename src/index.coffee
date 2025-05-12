import * as Type from "@dashkite/joy/type"
import Generic from "@dashkite/generic"
import Zest from "./zest"

isHTML = ( text ) ->
  (text.length > 2 ) &&
    ( text.startsWith "<" ) &&
    ( text.endsWith ">" )

$ = do ->

  ( Generic.make "$" )

    .define [ Type.isNullish ], -> Zest.make []
    
    .define [ Type.isGeneratorFunction ], ( g ) -> Zest.make g

    .define [ Type.isIterable ], ( it ) -> Zest.make it

    .define [ String, Node ], ( selector, root ) ->
      Zest.make root.querySelectorAll selector

    .define [ String ], ( selector ) ->
      Zest.make document.querySelectorAll selector

    .define [ isHTML ], ( html ) ->
      Zest.make do ->
        Document
          .parseHTMLUnsafe source
          .body
          .childNodes

    .define [ Node ], ( node ) -> Zest.make [ node ]

export default $
export { $ }
