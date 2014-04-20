module Feedjira
  class Parser
    class ParserNotFoundError < StandardError; end

    def self.parse(xml)
      new(xml).parse
    end

    attr_reader :xml

    def initialize(xml)
      @xml = xml
    end

    def parse
      raise ParserNotFoundError unless parser
      parser.parse xml
    end

    private

    def parser
      @parser ||= default_parsers.find { |parser| parser.able_to_parse? xml }
    end

    def default_parsers
      [Atom, Rss]
    end
  end
end
