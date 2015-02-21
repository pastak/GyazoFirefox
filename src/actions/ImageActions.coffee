AppDispatcher = require('../dispatcher/AppDispatcher')
Constants = require('../constants/Constants')

ImageActions =
  update: (data) ->
    AppDispatcher.handleViewAction
      actionType: Constants.ActionTypes.UPDATE_IMAGE
      data: data
  getImages: (tabId) ->
    addon.port.emit("getImages", tabId)

module.exports = ImageActions
