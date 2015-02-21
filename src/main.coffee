Request = require("sdk/request").Request
clipboard = require "sdk/clipboard"
Hotkey = require("sdk/hotkeys").Hotkey
tabs = require "sdk/tabs"
system = require "sdk/system"
ss = require "sdk/simple-storage"
GYAZO_HOST = ss.storage.gyazoHost || 'gyazo.com'

sideBar = require("sdk/ui/sidebar").Sidebar
  id: 'gyazo-sidebar'
  title: 'Gyazo'
  url: './html/sidebar.html'
  onAttach: (worker) ->
    worker.port.on("copy", (text) ->
      clipboard.set text
      worker.port.emit "copied"
    )
    worker.port.on("getTabs", ->
      Request(
        url: "https://#{GYAZO_HOST}/tabs.json"
        onComplete: (response) ->
          if response.status == 200
            worker.port.emit "responseTabs", JSON.stringify(response.json)
      ).get()
    )
    worker.port.on("getImages", (tabId)->
      tabId = 'history' unless tabId
      Request(
        url: "https://#{GYAZO_HOST}/tabs/#{tabId}/images.json?page=1"
        onComplete: (response) ->
          if response.status == 200
            worker.port.emit "updateImages", JSON.stringify(
              response.json.filter( (item) -> item.permalink_url)
            )
          else
            worker.port.emit "alert", "please login and reopen."
            tabs.open "https://#{GYAZO_HOST}/login"
      ).get()
    )
