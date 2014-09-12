(function () {
  angular.module('ds.quill', []).directive('quillContainer', function () {
    return {
      restrict: 'CE',
      template: '<div ng-transclude></div>',
      replace: true,
      transclude: true,
      scope: {},
      controller: [
        '$scope',
        '$element',
        '$attrs',
        function ($scope, $element, $attrs) {
          var ctrl, modules, _addModule;
          ctrl = this;
          modules = [];
          _addModule = function (name, config) {
            return ctrl.$editor.addModule(name, config);
          };
          this.init = function (editorEl) {
            var mod, _i, _len;
            ctrl.$editor = new Quill(editorEl.get(0), { theme: 'snow' });
            if (modules.length) {
              for (_i = 0, _len = modules.length; _i < _len; _i++) {
                mod = modules[_i];
                _addModule.apply(this, mod);
              }
              modules.length = 0;
            }
          };
          this.addModule = function (name, config) {
            if (ctrl.$editor) {
              _addModule.apply(this, arguments);
            } else {
              modules.push(arguments);
            }
          };
          return this;
        }
      ]
    };
  }).directive('quillEditor', [
    '$parse',
    function ($parse) {
      return {
        restrict: 'CE',
        priority: 0,
        template: '<div></div>',
        replace: true,
        require: '^quillContainer',
        scope: {
          textChange: '&onTextChange',
          getText: '@'
        },
        link: function (scope, element, attrs, ctrl) {
          return ctrl.init(element);
        }
      };
    }
  ]).directive('quillToolbar', function () {
    return {
      restrict: 'CE',
      templateUrl: 'template/ds-quill/toolbar.html',
      require: '^quillContainer',
      link: function (scope, element, attrs, ctrl) {
        return ctrl.addModule('toolbar', { container: element.get(0) });
      }
    };
  }).directive('quillPlaceholder', function () {
    return {
      require: '^quillContainer',
      link: function (scope, element, attrs, ctrl) {
        return ctrl.addModule('placeholder', { content: attrs.quillPlaceholder });
      }
    };
  }).run([
    '$templateCache',
    function ($templateCache) {
      var path, template, _ref, _results;
      _ref = { 'template/ds-quill/toolbar.html': '<!-- Font and Font Size -->\n<span class="ql-format-group">\n  <select title="Font" class="ql-font">\n    <option value="sans-serif" selected="">Sans Serif</option>\n    <option value="serif">Serif</option>\n    <option value="monospace">Monospace</option>\n  </select>\n  <select title="Size" class="ql-size">\n    <option value="10px">Small</option>\n    <option value="13px" selected="">Normal</option>\n    <option value="18px">Large</option>\n    <option value="32px">Huge</option>\n  </select>\n</span>\n\n<!-- Bold/Italic, etc. -->\n<span class="ql-format-group">\n  <span title="Bold" class="ql-format-button ql-bold"></span>\n  <span class="ql-format-separator"></span>\n  <span title="Italic" class="ql-format-button ql-italic"></span>\n  <span class="ql-format-separator"></span>\n  <span title="Underline" class="ql-format-button ql-underline"></span>\n  <span class="ql-format-separator"></span>\n  <span title="Strikethrough" class="ql-format-button ql-strike"></span>\n</span>\n\n<!-- Lists and alignment -->\n<span class="ql-format-group">\n  <span title="List" class="ql-format-button ql-list"></span>\n  <span class="ql-format-separator"></span>\n  <span title="Bullet" class="ql-format-button ql-bullet"></span>\n  <span class="ql-format-separator"></span>\n</span>' };
      _results = [];
      for (path in _ref) {
        template = _ref[path];
        _results.push($templateCache.put(path, template));
      }
      return _results;
    }
  ]);
}.call(this));
(function() {
  var Placeholder;

  Placeholder = (function() {
    function Placeholder(quill, options) {
      var _this = this;
      this.quill = quill;
      this.options = options;
      this.container = this.quill.addContainer('placeholder-container', true);
      this.container.innerHTML = this.options.content;
      this.quill.addStyles({
        ".placeholder-container": {
          opacity: 0.5,
          position: 'absolute'
        },
        ".placeholder-container.hide": {
          display: 'none'
        }
      });
      this.quill.on('text-change', function() {
        if (_this.quill.getText().trim().length) {
          return _this.container.classList.add('hide');
        } else {
          return _this.container.classList.remove('hide');
        }
      });
      this;
    }

    return Placeholder;

  })();

  Quill.registerModule('placeholder', Placeholder);

}).call(this);

(function() {


}).call(this);
