React = require 'react'
ImageList = require './compornents/imageList'
TabSelect = require './compornents/tabSelect'

ImageStore = require './stores/ImageStore'
ImageActions = require './actions/ImageActions'

TabStore = require './stores/TabStore'
TabActions = require './actions/TabActions'

addon.port.emit("getImages", 'history')
addon.port.on "updateImages", (data) ->
  ImageActions.update(data)
addon.port.on "copied", -> console.log('copied')
addon.port.on "alert", (data)-> window.alert(data)
addon.port.emit("getTabs")
addon.port.on "responseTabs", (data) ->
  TabActions.update(data)

SideBar = React.createClass
  getInitialState: ->
    tabs: []
    images: []
    selectedTab: 'history'
  stores: [ImageStore, TabStore]
  componentDidMount: ->
    ImageStore.addChangeListener(@_onChangeImages)
    TabStore.addChangeListener(@_onChangeTabs)
  componentWillUnmount: ->
    ImageStore.removeChangeListener(@_onChangeImages)
    TabStore.removeChangeListener(@_onChangeTabs)
  _onChangeTabs: ->
    addon.port.emit("getImages", TabStore.getSelectedTab())
  _onChangeImages: ->
    @setState
      images: ImageStore.getImages()
      tabs: TabStore.getTabs()
      selectedTab: TabStore.getSelectedTab()
  changeTab: (tab)->
    TabActions.changeTab(tab)
  render: ->
    <div>
      <TabSelect tabs={ @state.tabs } changeTab={ @changeTab } selectedTabId={ @state.selectedTab }/>
      <ImageList images={ @state.images }/>
    </div>
React.render <SideBar />, document.getElementById('imageList')
