AppDispatcher = require('../dispatcher/AppDispatcher')
Constants = require('../constants/Constants')

module.exports =
  update: (data) ->
    AppDispatcher.handleViewAction
      actionType: Constants.ActionTypes.UPDATE_TAB
      data: data
  changeTab: (tabId) ->
    AppDispatcher.handleViewAction
      actionType: Constants.ActionTypes.CHANGE_TAB
      selectedTab: tabId
