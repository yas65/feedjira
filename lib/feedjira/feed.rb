module Feedjira
  class Feed
    attr_reader :parser

    def initialize(parser)
      @parser = parser
    end

    def title
      parser.title
    end

    def description
      parser.description
    end

    def url
      parser.url
    end

    def links
      parser.links
    end

    def hubs
      parser.hubs
    end

    def entries
      parser.entries
    end
  end
end
