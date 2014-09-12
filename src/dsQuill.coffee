angular.module('ds.quill', []).directive 'quillContainer', ->
  restrict: 'E'
  template: '<div ng-transclude></div>'
  replace: true
  transclude: true
  scope: {}
  controller: ($scope, $element, $attrs) ->

    ctrl = @
    modules = []

    _addModule = (name, config) ->
      ctrl.$editor.addModule name, config

    @init = (editorEl) ->
      ctrl.$editor = new Quill(editorEl.get(0), theme: "snow")
      if modules.length
        _addModule.apply(@, mod) for mod in modules
        modules.length = 0
      return

    @addModule = (name, config) ->
      if ctrl.$editor
        _addModule.apply(@, arguments)
      else
        modules.push arguments
      return
    return @

.directive 'quillEditor', ($parse) ->
  restrict: 'E'
  priority: 0
  template: '<div></div>'
  replace: true
  require: '^quillContainer'
  scope:
    textChange: '&onTextChange'
    getText: '@'
  link: (scope, element, attrs, ctrl) ->
    # console.log 'quillEditor'
    ctrl.init(element)

.directive 'quillToolbar', ->
   restrict: 'E'
   template: '<div ng-transclude></div>'
   transclude: true
   replace: true
   require: '^quillContainer'
   link: (scope, element, attrs, ctrl) ->
     ctrl.addModule 'toolbar', container: element.get(0)

.directive 'quillPlaceholder', ->
  require: '^quillContainer'
  link: (scope, element, attrs, ctrl) ->
    ctrl.addModule 'placeholder', content: attrs.quillPlaceholder
