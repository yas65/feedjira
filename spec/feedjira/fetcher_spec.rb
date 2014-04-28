require 'spec_helper'

describe Feedjira::Fetcher do
  it 'fetches' do
    xml = Feedjira::Fetcher.fetch 'http://feedjira.com/blog/feed.xml'
    expect(xml).to eq sample_atom_middleman_feed
  end
end
