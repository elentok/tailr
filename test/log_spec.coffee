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

  describe "#getTailCommand", ->
    it_returns = (options, command) ->
      describe "when options are #{JSON.stringify(options)}", ->
        it "returns #{command}", ->
          log = new Log(options)
          expect(log.getTailCommand()).to.equal command

    it_returns { filename: '/path/to/file' }, "tail -n 30 -f '/path/to/file'"

  describe "#cleanOutput", ->
    it "removes the 0x0e / 14 / shift-out characeter", ->
      output = Log.cleanOutput("bla \u000e and more bla\u000e")
      expect(output).to.equal "bla  and more bla"
      


