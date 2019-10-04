process.env.NODE_ENV = process.env.NODE_ENV || 'production'

const webpack = require('@rails/webpacker');

// const environment = require('@rails/webpacker')
const MinifyPlugin = require('babel-minify-webpack-plugin');

const config = {
  module: {
    rules: [
      {
        test: /\.js$/,
        use: 'babel-loader',
        exclude: /node_modules/
      },
      {
        test: /\.css$/,
        use: [
          'style-loader',
          'css-loader'
        ]
      }
    ]
  },
  entry: './src/index.js',
  output: {

    filename: '[name].js',
    path: __dirname + "/dist/js"
  },
  plugins: [
   new MinifyPlugin()
 ]
}

module.exports = config;
