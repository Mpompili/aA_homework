// webpack.config.js
var path = require('path');

module.exports = {
  entry: './app.jsx',
  output: {
   path: path.resolve(__dirname),
   filename: "bundle.js"
 },
  module: {
    loaders: [
      {
        test: [/\.jsx?$/],
        exclude: /(node_modules)/,
        loader: 'babel-loader',
        query: {
          presets: ['env', 'react']
        }
      }
    ]
  },
  devtool: 'source-map',
  resolve: {
    extensions: ['.js', '.jsx', '*']
  }
};
