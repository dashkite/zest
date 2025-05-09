events = ( base = Object ) ->

  class extends base

    listen: ( event, handler ) ->
      @each ( el ) ->
        el.addEventListener event, handler

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

    bind: ( handler ) -> @listen "bind", handler

    blur: ( handler ) -> 
      if handler?
        @listen "blur", handler
      else
        @each ( el ) -> el.blur()

    change: ( handler ) -> @listen "change", handler

    click: ( handler ) -> 
      if handler?
        @listen "click", handler
      else
        @first?.click()
        @
    doubleclick: ( handler ) -> @listen "doubleclick", handler

    focus: ( handler ) -> 
      if handler?
        @listen "focus", handler
      else
        @first?.focus()
        @
    focusin: ( handler ) -> @listen "focusin", handler
    
    focusout: ( handler ) -> @listen "focusout", handler
    
    keyup: ( handler ) -> @listen "keyup", handler
    
    keydown: ( handler ) -> @listen "keydown", handler
    
    input: ( handler ) -> @listen "input", handler
    
    load: ( handler ) -> @listen "load", handler
    
    mouseup: ( handler ) -> @listen "mouseup", handler
    
    mousedown: ( handler ) -> @listen "mousedown", handler
    
    mouseenter: ( handler ) -> @listen "mouseenter", handler
    
    mouseover: ( handler ) -> @listen "mouseover", handler
    
    mouseout: ( handler ) -> @listen "mouseout", handler
    
    mousemove: ( handler ) -> @listen "mousemove", handler
    
    resize: ( handler ) -> @listen "resize", handler
    
    scroll: ( handler ) -> @listen "scroll", handler
    
    select: ( handler ) -> @listen "select", handler
    
    submit: ( handler ) -> @listen "submit", handler
    
    unload: ( handler ) -> @listen "unload", handler
    

export { events }