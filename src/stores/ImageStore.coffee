AppDispatcher = require('../dispatcher/AppDispatcher')
Constants = require('../constants/Constants')
assign = require('object-assign')
EventEmitter = require('events').EventEmitter

CHANGE_EVENT = 'change'
_images = []

ImageStore = assign EventEmitter.prototype,
  getImages: ->
    _images
  emitChange: ->
    @emit(CHANGE_EVENT);
  addChangeListener: (callback) ->
    @on(CHANGE_EVENT, callback)
  removeChangeListener: (callback) ->
    @removeListener(CHANGE_EVENT, callback)

AppDispatcher.register (payload) ->
  action = payload.action
  switch action.actionType
    when Constants.ActionTypes.UPDATE_IMAGE
      action.data = JSON.parse(action.data) if typeof action.data == 'string'
      _images = action.data
    else
      return true
  ImageStore.emitChange()
  true

module.exports = ImageStore
