clc = require 'cli-color'

module.exports = class Highlighter
  constructor: (@highlights) ->

  highlight: (text) ->
    for own pattern, color of @highlights
      regexp = new RegExp(pattern, 'gmi')
      text = text.replace regexp, (result) =>
        @getColorizer(color)(result)
    text
    
  getColorizer: (color) ->
    colorizer = clc
    for color in color.split(',')
      color = 'underline' if color is '_'
      colorizer = colorizer[color]
    colorizer
      
