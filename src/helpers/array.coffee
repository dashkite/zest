Arr =

  uniqueAndCompact: ( ax ) ->
    seen = new Set
    for a in ax when a? && !seen.has a
      seen.add a
      a

export default Arr