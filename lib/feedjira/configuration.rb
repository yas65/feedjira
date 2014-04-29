module Feedjira
  class Configuration
    DEFAULT_PARSERS = [
      Feedjira::Parser::Atom,
      Feedjira::Parser::Rss
    ]

    attr_accessor :parsers, :user_agent

    def initialize
      @parsers = DEFAULT_PARSERS
      @user_agent = "Feedjira v#{Feedjira::VERSION} http://feedjira.com"
    end
  end
end
