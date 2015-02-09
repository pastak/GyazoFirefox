addon.port.emit("ping");

addon.port.on "copied", -> console.log('copied')
addon.port.on("pong", (data) ->
  ImageList = React.createClass
    render: ->
      copy = (url) ->
        addon.port.emit("copy", url);
      items = JSON.parse(data).map (item)->
        <div onClick={ -> copy(item.permalink_url) }>
          <img 
            src={ item.thumb_url }
          />
        </div>
      <div>
        { items }
      </div>
  React.render <ImageList />, document.getElementById('imageList')
)
