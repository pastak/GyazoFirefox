React = require 'react'
module.exports = React.createClass
  render: ->
    copy = (url) ->
      addon.port.emit("copy", url);
    images = @props.images
    return null unless images.length
    items = images.map (item)->
      <div onClick={ -> copy(item.permalink_url) } key= { item.image_id } className='imageBox'>
        <img
          src={ item.url }
        />
      </div>
    <div>
      { items }
    </div>
