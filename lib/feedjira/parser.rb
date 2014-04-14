module Feedjira
  class Parser
    def self.parse(xml)
      new(xml).parse
    end

    attr_reader :xml

    def initialize(xml)
      @xml = xml
    end

    def parse
      parser.parse xml
    end

    private

    def parser
      default_parsers.find { |parser| parser.able_to_parse? xml }
    end

    def default_parsers
      [Feedjira::Parser::Atom, Feedjira::Parser::Rss]
    end
  end
end
