import { metaclass } from "./metaclass"

class Files extends metaclass()

  @make: ( list ) ->
    Object.assign ( new @ ), { list }

  @properties
    url:
      get: -> 
        if @list?[0]?
          URL.createObjectURL @list[0]

files = ( base = metaclass()) ->

  class extends base

    @properties
      files:
        get: -> Files.make @first.files


export { files }