module Feedjira
  class Parser
    class ParserNotFoundError < StandardError; end

    def self.parse(*args)
      new(*args).parse
    end

    attr_reader :xml

    def initialize(xml, options={})
      @xml = xml
      @parsers = options[:parsers] || []
      @parser = options[:parser]
    end

    def parse
      raise ParserNotFoundError unless parser
      parser.parse xml
    end

    private

    def parser
      @parser ||= @parsers.find { |parser| parser.able_to_parse? xml }
    end
  end
end
