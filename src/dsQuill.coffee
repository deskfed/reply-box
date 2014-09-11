angular.module('ds.quill', []).directive 'quillContainer', ->
  restrict: 'E'
  template: '<div ng-transclude></div>'
  replace: true
  transclude: true
  controller: ($scope, $element, $attrs) ->

    editor = null
    modules = []

    _addModule = (name, config) ->
      editor.addModule name, config

    @init = (editorEl) ->
      editor = new Quill(editorEl.get(0), theme: "snow")
      if modules.length
        _addModule.apply(@, mod) for mod in modules
        modules.length = 0

    @addModule = (name, config) ->
      if editor
        _addModule.apply(@, arguments)
      else
        modules.push arguments
      return
    return @


  # link: (scope, element, attrs) ->
  #   el0 = element.get(0)
  #     # Initialize editor with custom theme and modules
  #   fullEditor = new Quill(el0,
  #     modules:
  #       # toolbar:
  #       #
  #
  #       # authorship:
  #       #   authorId: "galadriel"
  #       #   enabled: true
  #
  #       # "multi-cursor": true
  #       # toolbar:
  #       #   container: el0
  #
  #       "link-tooltip": true
  #
  #     theme: "snow"
  #   )

    # Add basic editor's author
    # authorship = fullEditor.getModule("authorship")
    # authorship.addAuthor "gandalf", "rgba(255,153,51,0.4)"

    # Add a cursor to represent basic editor's cursor
    # cursorManager = fullEditor.getModule("multi-cursor")
    # cursorManager.setCursor "gandalf", fullEditor.getLength() - 1, "Gandalf", "rgba(255,153,51,0.9)"


.directive 'quillEditor', ->
   restrict: 'E'
   template: '<div></div>'
   replace: true
   require: '^quillContainer'
   link: (scope, element, attrs, ctrl) ->
     ctrl.init(element)

.directive 'quillToolbar', ->
   restrict: 'E'
   template: '<div ng-transclude></div>'
   transclude: true
   replace: true
   require: '^quillContainer'
   link: (scope, element, attrs, ctrl) ->
     ctrl.addModule 'toolbar', container: element.get(0)
