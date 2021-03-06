var path = require("path");

module.exports = {
  context: __dirname,
  entry: "./frontend/reactA06.jsx",
  output: {
    path: path.join(__dirname, 'app', 'assets', 'javascripts'),
    filename: "bundle.js"
  },
  resolve: {
    extensions: ["", ".js", ".jsx"]
  },
  module: {
    loaders: [
    {
      test: /\.jsx?$/,
      exclude: /(node_modules|bower_components)/,
      loader: 'babel?plugins[]=babel-plugin-rewire'
    },
    {
      test: /\.node$/,
      loader: "node-loader"
    }
    ]
  },
  devtool: 'source-maps',
  resolve: {
    extensions: ["", ".js", ".jsx" ]
  }
};
