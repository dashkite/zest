import * as Fn from "@dashkite/joy/function"
import Generic from "@dashkite/generic"

class Listener

  @make: ( zest ) ->
    Object.assign ( new @ ),
      { zest, options: {}, fx: [] }

  listen: Fn.chain ( @event ) ->

  bind: -> @listen "bind"
  blur: -> @listen "blur"
  change: -> @listen "change"
  click: -> @listen "click"
  doubleclick: -> @listen "doubleclick"
  focus: -> @listen "focus"
  focusin: -> @listen "focusin"
  focusout: -> @listen "focusout"
  keyup: -> @listen "keyup"
  keydown: -> @listen "keydown"
  input: -> @listen "input"
  load: -> @listen "load"
  mouseup: -> @listen "mouseup"
  mousedown: -> @listen "mousedown"
  mouseenter: -> @listen "mouseenter"
  mouseover: -> @listen "mouseover"
  mouseout: -> @listen "mouseout"
  mousemove: -> @listen "mousemove"
  resize: -> @listen "resize"
  scroll: -> @listen "scroll"
  select: -> @listen "select"
  submit: -> @listen "submit"
  unload: -> @listen "unload"

  capture: Fn.chain -> @options.capture = true
  
  stop: Fn.chain -> 
    @fx.push Fn.tee ( event ) -> event?.stopPropagation()

  prevent: Fn.chain ->
    @fx.push Fn.tee ( event ) -> event?.preventDefault()

  intercept: Fn.chain -> 
    @stop()
    @prevent()

  matches: Fn.chain ( selector ) ->
    @fx.push ( event ) -> 
      event if event? && event.target.matches selector
  
  within: Fn.chain ( selector ) ->
    @fx.push ( event ) -> 
      event if event? && ( event.target.closest selector )?

  apply: ( handler ) ->
    @fx.push ( event ) ->
      ( handler event ) if event?
    f = Fn.pipe @fx
    { options, event } = @
    @zest.each ( element ) =>
      element.addEventListener event, f, options 

events = ( base = Object ) ->

  class extends base

    listen: ( event ) -> 
      listener = Listener.make @
      ( listener.listen event ) if event?
      listener

    dispatch: do ->

      ( Generic.make "Zest::dispatch" )

        .define [ String ], ( name ) ->
          @each ( el ) ->
            el.dispatchEvent new CustomEvent name,
              bubbles: true
              cancelable: false
              composed: true

        .define [ Object ], ({ name, detail... }) ->
          @each ( el ) ->
            el.dispatchEvent new CustomEvent name,
              bubbles: true
              cancelable: false
              composed: true
              detail: detail

    blur: ( handler ) -> 
      @each ( el ) -> el.blur()

    click: ( handler ) -> 
      @each ( el ) -> el.click()

    focus: Fn.chain ( handler ) -> 
      @first?.focus()

    select: Fn.chain ( handler ) -> 
      @first?.select()

export { events }