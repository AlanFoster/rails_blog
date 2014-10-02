do ->
  on_each_load = (callback) ->
    $ callback
    ($ document).on 'page:load', callback

  on_each_load SyntaxHighlighter.highlight