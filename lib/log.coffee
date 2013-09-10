exec = (require 'child_process').exec
Connection = require 'ssh2'
fs = require 'fs'

module.exports = class Log
  constructor: (@options = {}) ->

  isRemote: ->
    @options.server? or @options.servers?
    
  getSshCommand: ->
    user = if @options.username? then "#{@options.username}@" else ''
    port = if @options.port? then " -p #{@options.port}" else ''
    cmd = "ssh -t #{user}#{@options.server}#{port}"

  getTailCommand: ->
    lines = @options.lines or 30
    sudo = if !!@options.sudo then 'sudo ' else ''
    "#{sudo}tail -n #{lines} -f '#{@options.filename}'"

  tail: ->
    if @isRemote()
      @tailRemote()
    else
      @tailLocal()

  tailLocal: ->
    cmd = @getTailCommand()
    console.log "Running: #{cmd}"
    console.log "======================================="
    proc = exec(cmd)
    proc.stdout.on 'data', (data) =>
      data = data.toString('utf-8')
      data = Log.cleanOutput(data)
      if @options.highlighter?
        data = @options.highlighter.highlight(data)
      process.stdout.write data

  tailRemote: ->
    if @options.server?
      @_tailSingleRemote(@options.server)
    else
      for server in @options.servers
        @_tailSingleRemote(server, true)


  _tailSingleRemote: (server) ->
    c = new Connection()
    c.on 'ready', =>
      console.log "Connected to #{server}"
      cmd = @getTailCommand()
      c.exec cmd, (err, stream) =>
        stream.on 'data', (data, extended) =>
          data = data.toString('utf-8')
          data = Log.cleanOutput(data)
          if @options.highlighter?
            data = @options.highlighter.highlight(data)
          process.stdout.write data
    c.connect
      host: server
      port: @options.port or 22
      username: @options.username or nil
      agent: process.env['SSH_AUTH_SOCK']

Log.cleanOutput = (text) ->
  text.replace /\u000e/g, ''
