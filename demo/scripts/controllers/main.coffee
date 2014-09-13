'use strict'

angular.module('replyBoxApp').controller 'MainCtrl', ($scope) ->

  @contentUpdated = ($content, $html) ->
    console.log $content, $html

  @getList = (key, cb = ->) ->
    console.log key
    key



  @
