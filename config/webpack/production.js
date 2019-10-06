process.env.NODE_ENV = process.env.NODE_ENV || 'production'

const environment = require('./environment')
var path = require('path');

// module.exports = environment.toWebpackConfig()
const TerserPlugin = require('terser-webpack-plugin');

module.exports = {
  module: {
    optimization: {
      minimize: true,
      minimizer: [new TerserPlugin()],
    }
  },
  entry: './src/index.js',
  output: {
    filename: 'bundle.js',
    path: path.resolve(__dirname, 'dist')
  }
};
