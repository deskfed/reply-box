class InsertLookup

  getInsertKey = (input, triggerChar, position) ->
    input = input.slice(0, position)  if position
    triggerCharIndex = (input || '').lastIndexOf(triggerChar)

    (if triggerCharIndex == -1 then undefined else input.slice(triggerCharIndex + triggerChar.length, position))

  constructor: (@quill, @options) ->
    # Defaults
    @options.triggerChar ?= '##'

    getCursorPosition = =>
      ret = {}
      selection = @quill.getSelection()
      if selection.start == selection.end
        if (sel = @quill.editor.root.ownerDocument.getSelection()) && sel.rangeCount > 0
          if (selrg = sel.getRangeAt(0))
            if (rects = selrg.getClientRects()).length > 0
              ret = rects[0]
        ret.index = selection.start

      return ret

    if @options.callback
      # Hide/show placeholder
      @quill.on 'text-change', (diff, direction) =>
        cursorPosition = getCursorPosition()
        key = getInsertKey @quill.getText(), @options.triggerChar, cursorPosition.index
        @options.callback key, cursorPosition


    @

Quill.registerModule('insertLookup', InsertLookup)
