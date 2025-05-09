import Zest from "./zest"

$ = do ->

  ( Generic.make "$" )

    .define [ String ], ( selector ) ->
      Zest.make selectorAll selector

    .define [ String, Node ], ( selector, root ) ->
      Zest.make selectorAll selector, root

    .define [ Zest ], Fn.identity

    .define [ Node ], ( node ) -> List.make [ node ]

    .define [ NodeList ], ( list ) -> List.make list

export default $
export { $ }
