React = require 'react'
module.exports = React.createClass
  _onChange: (event) ->
    @props.changeTab(event.target.value)
  render: ->
    return null unless @props.tabs.length
    tabs = @props.tabs.map (item) =>
      <option
        key={ item.id }
        value={ item.id }
      >
        { item.name }
      </option>
    <select
      className='tabSelect'
      onChange={ @_onChange }
      value={ @props.selectedTabId }
    >
      { tabs }
    </select>
