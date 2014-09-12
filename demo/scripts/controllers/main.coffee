'use strict'

angular.module('replyBoxApp').controller 'MainCtrl', ($scope) ->

  @contentUpdated = ($content, $html) ->
    console.log $content, $html

  @poller = ($content, $html) ->
    console.log $content, $html


  @
