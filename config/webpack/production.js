/* eslint-disable */
process.env.NODE_ENV = process.env.NODE_ENV || 'production'

const environment = require('./environment')
const ignoreLoader = require('./loaders/ignore');
environment.loaders.append('ignore', ignoreLoader);

module.exports = environment.toWebpackConfig()
