class Placeholder
  constructor: (@quill, @options) ->
    @container = @quill.addContainer('placeholder-container', true)
    @container.innerHTML = @options.content

    @quill.addStyles(
      ".placeholder-container":
        opacity: 0.5
        position: 'absolute'
      ".placeholder-container.hide":
        display: 'none'
    )

    # Hide/show placeholder
    @quill.on 'text-change', =>
      # getLength() always includes a whitespace, so it's never 0
      if @quill.getText().trim().length
        @container.classList.add('hide')
      else
        @container.classList.remove('hide')

    @

Quill.registerModule('placeholder', Placeholder)
