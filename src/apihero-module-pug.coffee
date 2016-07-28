fs   = require 'fs'
path = require 'path'
pug = require 'pug'

module.exports.pug = pug

_app = null
  
setViewDir = (path)=>
  return unless _app?
  _app.set 'views', path
  fs.stat viewsPath, (e, stat)->
    if (e)
      console.log "views directory not found at #{viewsPath}. creating"
      fs.mkDir viewsPath, (e,res)->
        console.log e if e?
        
getViewDir = =>
  return null unless _app?
  _app.get 'views'

module.exports.setViewDir = setViewDir
module.exports.getViewDir = getViewDir

module.exports.init = (app, options, callback)-> 
  throw "apihero-module-pug::init - callback required" unless typeof (cB = arguments[arguments.length - 1]) is 'function'
  _app = app
  options = {} unless options? and typeof options is 'object'
  unless (viewsPath = if options.hasOwnProperty 'viewsPath' then options.viewsPath else app.get 'views')?
    setViewsDir path.join app_root, 'views'