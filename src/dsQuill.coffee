angular.module('ds.quill', []).directive 'quillContainer', ->
  restrict: 'CE'
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
  restrict: 'CE'
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
  restrict: 'CE'
  templateUrl: 'template/ds-quill/toolbar.html'
  require: '^quillContainer'
  link: (scope, element, attrs, ctrl) ->
    ctrl.addModule 'toolbar', container: element.get(0)

.directive 'quillPlaceholder', ->
  require: '^quillContainer'
  link: (scope, element, attrs, ctrl) ->
    ctrl.addModule 'placeholder', content: attrs.quillPlaceholder

.run ($templateCache) ->

  $templateCache.put(path, template) for path, template of {
    "template/ds-quill/toolbar.html": \
    """
    <!-- Font and Font Size -->
    <span class="ql-format-group">
      <select title="Font" class="ql-font">
        <option value="sans-serif" selected="">Sans Serif</option>
        <option value="serif">Serif</option>
        <option value="monospace">Monospace</option>
      </select>
      <select title="Size" class="ql-size">
        <option value="10px">Small</option>
        <option value="13px" selected="">Normal</option>
        <option value="18px">Large</option>
        <option value="32px">Huge</option>
      </select>
    </span>

    <!-- Bold/Italic, etc. -->
    <span class="ql-format-group">
      <span title="Bold" class="ql-format-button ql-bold"></span>
      <span class="ql-format-separator"></span>
      <span title="Italic" class="ql-format-button ql-italic"></span>
      <span class="ql-format-separator"></span>
      <span title="Underline" class="ql-format-button ql-underline"></span>
      <span class="ql-format-separator"></span>
      <span title="Strikethrough" class="ql-format-button ql-strike"></span>
    </span>

    <!-- Lists and alignment -->
    <span class="ql-format-group">
      <span title="List" class="ql-format-button ql-list"></span>
      <span class="ql-format-separator"></span>
      <span title="Bullet" class="ql-format-button ql-bullet"></span>
      <span class="ql-format-separator"></span>
    </span>
    """
  }

