fs = require 'fs'
path = require 'path'

Log = require './log'


module.exports = class Tailr
  constructor: (@options = {}) ->
    @_config = null
    @options.config_path or= path.join(process.env['HOME'], '.tailr.coffee')
  
  getLogs: ->
    @_getConfig().logs

  _getConfig: ->
    return @_config if @_config?
    if fs.existsSync(@options.config_path)
      @_config = require(@options.config_path)
    else
      @_config = { logs: {} }
    @_config

  tail: (logName) ->
    logOptions = @_getConfig().logs[logName]
    if logOptions?
      log = new Log(logOptions)
      log.tail()
    else
      console.log "Invalid log name '#{logName}', " +
       "use 'tailr list' to see all available logs"


    

