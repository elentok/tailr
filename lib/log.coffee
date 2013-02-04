exec = (require 'child_process').exec

module.exports = class Log
  constructor: (@options = {}) ->

  isRemote: ->
    @options.server?
    
  getSshCommand: ->
    user = if @options.username? then "#{@options.username}@" else ''
    port = if @options.port? then " -p #{@options.port}" else ''
    cmd = "ssh #{user}#{@options.server}#{port}"

  getTailCommand: ->
    "tail -n 30 -f '#{@options.filename}'"

  getCommand: ->
    if @isRemote()
      ssh = @getSshCommand()
      tail = @getTailCommand()
      "#{ssh} \"#{tail}\""
    else
      @getTailCommand()

  tail: ->
    cmd = @getCommand()
    console.log "Running: #{cmd}"
    console.log "======================================="
    proc = exec(cmd)
    proc.stdout.on 'data', (data) ->
      process.stdout.write data.toString('utf-8')
