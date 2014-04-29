require 'spec_helper'

describe Feedjira::Fetcher do
  describe '#fetch' do
    it 'returns the fetched xml' do
      fetcher = Feedjira::Fetcher.new 'http://feedjira.com/blog/feed.xml', Faraday.default_connection
      expect(fetcher.fetch).to eq sample_atom_middleman_feed
    end
  end
end
