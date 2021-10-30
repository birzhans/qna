const { environment } = require('@rails/webpacker')

const webpack = require("webpack")
environment.plugins.append("Provide", new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery',
    Popper: ['popper.js', 'default']
}))

const HbsLoader = {
   test: /\.hbs/,
   loader: 'handlebars-loader'
 }
environment.loaders.append('hbs', HbsLoader)

module.exports = environment
