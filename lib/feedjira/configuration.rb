module Feedjira
  class Configuration
    DEFAULT_PARSERS = [
      Feedjira::Parser::Atom,
      Feedjira::Parser::Rss
    ]

    attr_accessor :parsers

    def initialize
      @parsers = DEFAULT_PARSERS
    end
  end
end
