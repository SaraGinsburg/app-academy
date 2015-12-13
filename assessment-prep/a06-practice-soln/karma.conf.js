var webpack = require('webpack');
var path = require('path');
var webpackConfig = require('./webpack.config');

delete webpackConfig.entry;
webpackConfig.devtool = 'inline-source-map';

module.exports = function (config) {
  config.set({
    browsers: [ 'PhantomJS' ],
    frameworks: [ 'jasmine' ],
    files: [
      'tests.webpack.js',
      'https://code.jquery.com/jquery-1.11.2.min.js'
    ],
    preprocessors: {
      'tests.webpack.js': [ 'webpack', 'sourcemap' ]
    },
    reporters: [ 'dots' ],
    webpack: webpackConfig,
    webpackServer: {
      noInfo: true
    }
  });
};
