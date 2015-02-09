Request = require("sdk/request").Request
clipboard = require "sdk/clipboard"

sideBar = require("sdk/ui/sidebar").Sidebar
  id: 'gyazo-sidebar'
  title: 'Gyazo'
  url: './html/sidebar.html'
  onAttach: (worker) ->
    worker.port.on("copy", (text) ->
      clipboard.set text
      worker.port.emit "copied"
    )
    worker.port.on("ping", ->
      Request(
        url: 'https://gyazo.com/tabs/history/images.json?page=1'
        onComplete: (data) ->
          worker.port.emit "pong", JSON.stringify(
            data.json.filter( (item) -> item.permalink_url)
          )
      ).get()
    )
