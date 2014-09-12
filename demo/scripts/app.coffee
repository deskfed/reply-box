'use strict'

angular.module('replyBoxApp', [
  'ui.router'
  'ds.quill'
])
  .config ($stateProvider) ->
    $stateProvider
      .state 'main',
        url: ''
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
        controllerAs: 'main'
