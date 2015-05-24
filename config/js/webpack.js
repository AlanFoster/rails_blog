var ExtractTextPlugin = require("extract-text-webpack-plugin");

module.exports = {
  "bail": true,
  "output": {
    "filename": "application.js"
  },
  "module": {
    "loaders": [
      {"test": /\.coffee$/, "loader": "coffee-loader"},
      {"test": /\.css$/, "loader": ExtractTextPlugin.extract("style-loader", "css-loader")}
    ]
  },
  "resolve": {
    "extensions": [
      "",
      ".js",
      ".coffee"
    ],
    "moduleDirectories": [
      "node_modules"
    ]
  },
  "plugins": [
    new ExtractTextPlugin("style.css", {
      allChunks: true
    })
  ]
};
