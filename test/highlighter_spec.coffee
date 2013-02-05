Highlighter = require '../lib/highlighter'
expect = (require 'chai').expect

red   = "\u001b[31m"
blue  = "\u001b[34m"
reset = "\u001b[39m"

describe "Highlighter", ->
  describe "#highlight", ->
    describe "text is 'hello, my name is bob'", ->
      describe "when options are { 'name': 'red' }", ->
        it "returns 'hello, my {red}name{reset} is bob'", ->
          text = 'hello, my name is bob'
          highlighter = new Highlighter('name': 'red')
          output = highlighter.highlight(text)
          expect(output).to.equal "hello, my #{red}name#{reset} is bob"
          
      describe "when options are { '^.*name.*$': 'red' }", ->
        it "{red}returns 'hello, my name is bob'{reset}", ->
          text = 'hello, my name is bob'
          highlighter = new Highlighter('^.*name.*$': 'red')
          output = highlighter.highlight(text)
          expect(output).to.equal "#{red}hello, my name is bob#{reset}"


