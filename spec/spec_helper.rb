require File.expand_path(File.dirname(__FILE__) + '/../lib/feedjira')
require 'sample_feeds'

RSpec.configure do |c|
  c.include SampleFeeds

  c.before(:all) do
    stubs = Faraday::Adapter::Test::Stubs.new do |stub|
      stub.get('/blog/feed.xml') {[ 200, {}, sample_atom_middleman_feed ]}
      stub.get('http://tenderlovemaking.com/feed/') {[ 200, {}, sample_rss_feed ]}
    end

    Faraday.default_connection = Faraday.new do |b|
      b.adapter :test, stubs
    end
  end
end
