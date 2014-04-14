require File.expand_path(File.dirname(__FILE__) + '/../lib/feedjira')
require 'sample_feeds'
require 'faraday_stubs'

RSpec.configure do |c|
  c.include SampleFeeds
  c.include FaradayStubs
end
