$ = require 'jquery'
highlighter = require 'highlight.js'

highlight_code_snippets = (selector) ->
  ($ selector).each (i, block) ->
    highlighter.highlightBlock(block)

module.exports =
  highlight: (selector) ->
    -> highlight_code_snippets(selector)
