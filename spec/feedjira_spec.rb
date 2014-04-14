require 'spec_helper'

describe Feedjira do
  it 'fetches and parses a feed' do
    feed = Feedjira.fetch_and_parse 'http://feedjira.com/blog/feed.xml', conn
    expect(feed).to be_a Feedjira::Parser::Atom
  end
end
