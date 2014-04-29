require 'spec_helper'

describe Feedjira::Fetcher do
  describe '#fetch' do
    it 'returns the fetched xml' do
      fetcher = Feedjira::Fetcher.new 'http://feedjira.com/blog/feed.xml'
      expect(fetcher.fetch).to eq sample_atom_middleman_feed
    end
  end

  describe 'user agent' do
    it 'gets set to the default' do
      fetcher = Feedjira::Fetcher.new nil
      user_agent = fetcher.conn.headers[:user_agent]
      expect(user_agent).to eq Feedjira.configuration.user_agent
    end
  end
end
