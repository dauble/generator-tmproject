
define (require) ->

    $ = require 'jquery'
    Templates = require 'templates/templates'

    class MyModule

        constructor: ->

            @template = Templates['app/assets/javascripts/templates/myModule.hbs']

            $('body').append @template()

            console.log 'constructor: MyModule with templates'


    MyModule