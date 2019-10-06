process.env.NODE_ENV = process.env.NODE_ENV || 'production'

const environment = require('./environment')
const UglifyJsPlugin = require('uglifyjs-webpack-plugin');


// module.exports = environment.toWebpackConfig()

module.exports = function() {
  console.log("BUILDING PRODUCTION");

  return webpackMerge(commonConfig(), {

    plugins: [

      new UglifyJsPlugin({
        test: /\.js($|\?)/i,
        sourceMap: true,
        uglifyOptions: {
          mangle: {
            keep_fnames: true,
          },
          compress: {
            warnings: false,
          },
          output: {
            beautify: false,
          }
        }
      })
    ]
  });
};
