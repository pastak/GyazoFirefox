keyMirror = require('react/lib/keyMirror')

module.exports =
  ActionTypes: keyMirror
    EVENT_CHANGE: 'change',
    UPDATE_IMAGE: 'update_image',
    UPDATE_TAB: 'update_tab',
    CHANGE_TAB: 'change_tab'
  PayloadSources: keyMirror
    VIEW_ACTION: 'VIEW_ACTION'
