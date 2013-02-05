Log = require '../lib/log'
expect = (require 'chai').expect

describe "Log", ->
  describe "#isRemote", ->
    it "is true when 'server' is defined", ->
      log = new Log(server: 'myserver')
      expect(log.isRemote()).to.be.true

    it "is false when 'server' isn't defined", ->
      log = new Log()
      expect(log.isRemote()).to.be.false

  describe "#getSshCommand", ->
    it_returns = (options, command) ->
      describe "when options are #{JSON.stringify(options)}", ->
        it "returns #{command}", ->
          log = new Log(options)
          expect(log.getSshCommand()).to.equal command

    it_returns { server: 'myserver' }, "ssh myserver"
    it_returns { server: 'myserver', port: 1234 }, "ssh myserver -p 1234"
    it_returns { server: 'myserver', port: 1234, username: 'bob' },
      "ssh bob@myserver -p 1234"

  describe "#getTailCommand", ->
    it_returns = (options, command) ->
      describe "when options are #{JSON.stringify(options)}", ->
        it "returns #{command}", ->
          log = new Log(options)
          expect(log.getTailCommand()).to.equal command

    it_returns { filename: '/path/to/file' }, "tail -n 30 -f '/path/to/file'"

  describe "#getCommand", ->
    it_returns = (options, command) ->
      describe "when options are #{JSON.stringify(options)}", ->
        it "returns #{command}", ->
          log = new Log(options)
          expect(log.getCommand()).to.equal command

    it_returns { filename: '/path/to/file' }, "tail -n 30 -f '/path/to/file'"
    it_returns {
      server: 'myserver',
      port: '1234',
      username: 'bob',
      filename: '/path/to/file' },
      "ssh bob@myserver -p 1234 \"tail -n 30 -f '/path/to/file'\""
    it_returns { filename: '/path/to/file', sudo: yes }, "sudo tail -n 30 -f '/path/to/file'"
    it_returns { filename: '/path/to/file', sudo: no }, "tail -n 30 -f '/path/to/file'"
