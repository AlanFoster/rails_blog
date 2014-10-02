do ->
  highlight_code = -> SyntaxHighlighter.highlight()
  $ highlight_code
  ($ document).on 'page:load', highlight_code

