fs = require 'fs'
path = require 'path'

Log = require './log'
Highlighter = require './highlighter'


module.exports = class Tailr
  constructor: (@options = {}) ->
    @_config = null
    @options.config_path or= path.join(process.env['HOME'], '.tailr.coffee')
    @options.wordsToHighlight or= []

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
      logOptions.highlighter = @_createHighlighter()
      logOptions.lines = @options.lines
      log = new Log(logOptions)
      log.tail()
    else
      console.log "Invalid log name '#{logName}', " +
       "use 'tailr list' to see all available logs"

  _createHighlighter: ->
    highlights =
      "^.*error.*$": 'red'
      "err(or)?": 'red,_'

    if @_getConfig().highlights?
      for own key, value of @_getConfig().highlights
        highlights[key] = value

    for word in @options.wordsToHighlight
      if word.indexOf('=') != -1
        [word, color] = word.split('=')
      else
        color = 'green,_'
      highlights[word] = color
    new Highlighter(highlights)

