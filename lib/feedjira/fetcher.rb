module Feedjira
  class Fetcher
    def self.fetch(url)
      new(url).fetch
    end

    attr_reader :url

    def initialize(url)
      @url = url
    end

    def fetch
      response = conn.get url
      response.body
    end

    def conn
      conn = Faraday.default_connection
      conn.headers[:user_agent] = Feedjira.configuration.user_agent
      conn
    end
  end
end
