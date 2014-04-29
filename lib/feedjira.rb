require 'sax-machine'
require 'faraday'
require 'loofah'

require 'feedjira/core_ext'
require 'feedjira/error'
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
    xml = Fetcher.fetch url, options.fetch(:connection, conn)
    Feed.new Parser.parse xml, default_parser_options.merge(options.fetch(:parser_options,{}))
  end

  def self.default_parser_options
    {parsers: configuration.parsers}
  end

  def self.conn
    Faraday.new(nil, headers: { user_agent: configuration.user_agent })
  end

  def self.config
    yield configuration
    configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end
end
