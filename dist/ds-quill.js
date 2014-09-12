(function () {
  angular.module('ds.quill', []).directive('quillContainer', function () {
    return {
      restrict: 'E',
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
        restrict: 'E',
        priority: 0,
        template: '<div></div>',
        replace: true,
        require: '^quillContainer',
        scope: {
          textChange: '&onTextChange',
          getText: '@'
        },
        link: function (scope, element, attrs, ctrl) {
          $parse.log('quillEditor');
          return ctrl.init(element);
        }
      };
    }
  ]).directive('quillToolbar', function () {
    return {
      restrict: 'E',
      template: '<div ng-transclude></div>',
      transclude: true,
      replace: true,
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
  });
}.call(this));