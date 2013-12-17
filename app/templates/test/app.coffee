casper.start 'http://trendyminds.com', ->
  # Test welcome message
  @.test.assertUrlMatch 'http://trendyminds.com', 'TrendyMinds.com can be reached successfully'

  # Test link to About page
  @.clickLabel 'About', 'a'
  @.then ->
    @.test.assertUrlMatch 'http://trendyminds.com/about/', 'User can access the About page from the homepage'

casper.thenOpen 'http://trendyminds.com', ->
  # Test link to Blog page
  @.clickLabel 'Blog', 'a'
  @.then ->
    @.test.assertUrlMatch 'http://trendyminds.com/blog', 'User can access the Blog page from the homepage'

casper.run ->
  @.test.done()