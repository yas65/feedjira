require 'sax-machine'
require 'faraday'
require 'loofah'

require 'feedjira/core_ext'
require 'feedjira/fetcher'
require 'feedjira/parser'
require 'feedjira/feed_entry_utilities'
require 'feedjira/feed_utilities'
require 'feedjira/parser/rss_entry'
require 'feedjira/parser/rss'
require 'feedjira/parser/atom_entry'
require 'feedjira/parser/atom'

module Feedjira
  def self.fetch_and_parse(*args)
    Parser.parse Fetcher.fetch *args
  end
end
