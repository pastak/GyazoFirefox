AppDispatcher = require('../dispatcher/AppDispatcher')
Constants = require('../constants/Constants')
assign = require('object-assign')
EventEmitter = require('events').EventEmitter

CHANGE_EVENT = 'change'
_tabs = []
_selected_tab = 'history'
TabStore = assign EventEmitter.prototype,
  getTabs: ->
    _tabs
  getSelectedTab: ->
    _selected_tab
  emitChange: ->
    @emit(CHANGE_EVENT);
  addChangeListener: (callback) ->
    @on(CHANGE_EVENT, callback)
  removeChangeListener: (callback) ->
    @removeListener(CHANGE_EVENT, callback)

AppDispatcher.register (payload) ->
  action = payload.action
  switch action.actionType
    when Constants.ActionTypes.UPDATE_TAB
      action.data = JSON.parse(action.data) if typeof action.data == 'string'
      _tabs = action.data
    when Constants.ActionTypes.CHANGE_TAB
      _selected_tab = action.selectedTab
    else
      return true
  TabStore.emitChange()
  true

module.exports = TabStore
