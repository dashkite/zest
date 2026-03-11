import { metaclass } from "@dashkite/joy/metaclass"

class Modify

  @make: ( zest ) ->
    Object.assign ( new @ ), { zest }

  attributes: ( names, handler ) ->
    do ({ observer } = {}) =>
      observer = new MutationObserver ( record ) ->
        handler record.target
      @zest.each ( element ) ->
        observer.observe element, 
          attributes: true
          attributeFilter: names

  children: ( handler ) ->
    do ({ observer } = {}) =>
      observer = new MutationObserver ( record ) -> 
        handler record.target
      @zest.each ( element ) ->
        observer.observe element, childList: true

  descendents: ( handler ) ->
    do ({ observer } = {}) =>
      observer = new MutationObserver ( record ) -> 
        handler record.target
      @zest.each ( element ) ->
        observer.observe element, 
          childList: true
          subtree: true

observers = ( base = metaclass()) ->

  class extends base

    @getters

      modify: -> Modify.make @
  
    show: do ({ visible } = {}) ->
      visible = ( event ) -> event.isIntersecting
      ( handler ) ->
        do ({ observer } = {}) =>
          observer = new IntersectionObserver ( events ) ->
            if ( event = events.find visible )?
              handler event.target
          @each ( element ) -> observer.observe element

    hide: do ({ invisible } = {}) ->
      invisible = ( event ) -> event.intersectionRatio <= 0
      ( handler ) ->
        do ({ observer } = {}) =>
          observer = new IntersectionObserver ( events ) ->
            if ( event = events.some invisible )?
              handler event.target
          @each ( element ) -> observer.observe element

export { observers }