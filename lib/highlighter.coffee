clc = require 'cli-color'

module.exports = class Highlighter
  constructor: (@highlights) ->

  highlight: (text) ->
    for own pattern, color of @highlights
      regexp = new RegExp(pattern, 'gmi')
      text = text.replace regexp, (result) =>
        clc[color](result)
    text
