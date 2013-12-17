#global require
"use strict"

require.config

    shim:
        handlebars:
            exports: "Handlebars"
            # https://github.com/gruntjs/grunt-contrib-handlebars/issues/48
            init: ->
                this.Handlebars = Handlebars
                this.Handlebars

    paths:
        jquery: '../../bower_components/jquery/jquery'
        handlebars: "../../bower_components/handlebars.js/dist/handlebars"

require ['App'], (App) ->

    new App