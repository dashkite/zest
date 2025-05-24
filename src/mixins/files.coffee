import { metaclass } from "@dashkite/joy/metaclass"

class Files extends metaclass()

  @make: ( list ) ->
    Object.assign ( new @ ), { list }

  @getters
    url: -> 
      if @list?[0]?
        URL.createObjectURL @list[0]

files = ( base = metaclass()) ->

  class extends base

    @getters
      files: -> Files.make @first.files


export { files }