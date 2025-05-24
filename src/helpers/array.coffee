Arr =

  normalize: ( ax ) ->
    seen = new Set
    bx = ( Iterator.from ax )
      .flatMap ( a ) ->
        if Array.isArray a then a else [ a ]
    for b from bx when b? && !seen.has b
      seen.add b
      b    

export default Arr