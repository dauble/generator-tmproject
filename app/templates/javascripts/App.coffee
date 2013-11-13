define (require) ->

    $ = require 'jquery'
    MyModule = require 'modules/MyModule'

    start = ->
        myModule = new MyModule()

        console.log 'created: MyModule'

    start: start