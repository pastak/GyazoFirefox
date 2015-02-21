Dispatcher = require('flux').Dispatcher
assign = require('object-assign')
module.exports = assign(new Dispatcher(),
  handleViewAction: (action) ->
    @dispatch
      source: 'VIEW_ACTION',
      action: action
)
