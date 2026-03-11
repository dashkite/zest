Handler =

  get: ( target, name ) ->
    if name == "toJSON"
      -> target.data
    else
      target.get name
  
  set: ( target, name, value ) ->
    target.set name, value

  deleteProperty: ( target, name ) ->
    target.remove name

  has: ( target, name ) ->
    target.has name

  ownKeys: ( target ) -> target.keys
    
  getOwnPropertyDescriptor: ( target, property ) ->
    if property in target.keys
      enumerable: true
      configurable: true
      value: target.get property

export default Handler