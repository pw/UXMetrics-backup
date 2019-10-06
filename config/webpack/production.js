process.env.NODE_ENV = process.env.NODE_ENV || 'production'

const environment = require('./environment')

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
   filename: '[name].js',
   path: __dirname + "/dist/js"
 }
};
