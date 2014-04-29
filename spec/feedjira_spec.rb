require 'spec_helper'

describe Feedjira do
  describe '#fetch_and_parse' do
    it 'fetches and parses an Atom feed' do
      feed = Feedjira.fetch_and_parse 'http://feedjira.com/blog/feed.xml'
      expect(feed.title).to eq 'Feedjira Blog'
      expect(feed.description).to eq 'A Blog for Feedjira'
      expect(feed.url).to eq 'http://feedjira.com/blog'
      expect(feed.entries.size).to eq 1

      entry = feed.entries.first
      expect(entry.author).to eq 'Jon Allured'
      expect(entry.categories).to eq []
      expect(entry.content).to match /My request was totally out of the blue/
      expect(entry.entry_id).to eq 'http://feedjira.com/blog/2014/03/17/feedjira-goes-one-point-oh.html'
      expect(entry.image).to eq nil
      expect(entry.published).to eq Time.parse('2014-03-17 00:00:00 UTC')
      expect(entry.summary).to eq nil
      expect(entry.title).to eq 'Feedjira Goes One-Point-Oh'
      expect(entry.url).to eq 'http://feedjira.com/blog/2014/03/17/feedjira-goes-one-point-oh.html'
    end

    it 'fetches and parses an RSS feed' do
      feed = Feedjira.fetch_and_parse 'http://tenderlovemaking.com/feed/'
      expect(feed.title).to eq 'Tender Lovemaking'
      expect(feed.description).to eq 'The act of making love, tenderly.'
      expect(feed.url).to eq 'http://tenderlovemaking.com'
      expect(feed.entries.size).to eq 10

      entry = feed.entries.first
      expect(entry.author).to eq 'Aaron Patterson'
      expect(entry.categories).to eq %w(computadora nokogiri rails)
      expect(entry.content).to match /This means that a new search is executed for every method call/
      expect(entry.entry_id).to eq 'http://tenderlovemaking.com/?p=198'
      expect(entry.image).to eq nil
      expect(entry.published).to eq Time.parse('2008-12-04 17:17:49 UTC')
      expect(entry.summary).to match /It lets you sloppily explore documents/
      expect(entry.title).to eq 'Nokogiri’s Slop Feature'
      expect(entry.url).to eq 'http://tenderlovemaking.com/2008/12/04/nokogiris-slop-feature/'
    end

    context 'with a supplied parser' do
      it 'uses that parser' do
        parser = Class.new
        doc = double(title: nil, description: nil, url: nil, entries: [])
        parser.should_receive(:parse).and_return(doc)
        url = 'http://feedjira.com/blog/feed.xml'
        parser_options = { parser: parser }
        Feedjira.fetch_and_parse url, parser_options: parser_options
      end
    end
  end

  describe "config with a block" do
    it "returns the configuration" do
      ret = Feedjira.config {}
      expect(ret).to equal(Feedjira.configuration)
    end

    it "sets parsers" do
      parser = Class.new
      Feedjira.config { |c| c.parsers = [parser] }
      expect(Feedjira.configuration.parsers).to eq [parser]
    end
  end
end
