require 'sax-machine'
require 'faraday'
require 'loofah'

require 'feedjira/core_ext'
require 'feedjira/feed'
require 'feedjira/entry'
require 'feedjira/fetcher'
require 'feedjira/parser'

require 'feedjira/feed_entry_utilities'
require 'feedjira/feed_utilities'
require 'feedjira/parser/rss_entry'
require 'feedjira/parser/rss'
require 'feedjira/parser/atom_entry'
require 'feedjira/parser/atom'

require 'feedjira/configuration'

module Feedjira
  def self.fetch_and_parse(url, options={})
    xml = Fetcher.fetch url
    Feed.new Parser.parse xml, options.fetch(:parser_options, {})
  end

  def self.config
    yield configuration
    configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end
end
