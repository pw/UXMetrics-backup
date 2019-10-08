process.env.NODE_ENV = process.env.NODE_ENV || 'production'

const webpack = require('@rails/webpacker');

// const environment = require('@rails/webpacker')
module.exports = {
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: "babel-loader"
        }
      }
    ]
  }
}
