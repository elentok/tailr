Tailr = require '../lib/tailr'
expect = (require 'chai').expect
path = require 'path'

describe "Tailr", ->
  describe "getLogs", ->
    it "returns the 'logs' section of the log file", ->
      config_path = path.join(__dirname, 'fixtures', 'tailr1.coffee')
      tailr = new Tailr(config_path: config_path)
      logs = tailr.getLogs()
      expect(logs).to.eql
        log1:
          server: 'myserver'
          port: '123'
          filename: '/home/user/app/log.log'
        log2:
          filename: '/local/app/log.log'


