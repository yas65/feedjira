module Feedjira
  class Parser
    class ParserNotFoundError < StandardError; end

    def self.parse(*args)
      new(*args).parse
    end

    attr_reader :xml

    def initialize(xml, options={})
      @xml = xml
      @parser = options[:parser]
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
      Feedjira.configuration.parsers
    end
  end
end
