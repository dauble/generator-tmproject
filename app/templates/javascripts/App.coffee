define (require) ->

    $ = require 'jquery'
    MyModule = require 'modules/MyModule'

    class App

        constructor: ->

            myModule = new MyModule()

            console.log 'created: MyModule'

    App