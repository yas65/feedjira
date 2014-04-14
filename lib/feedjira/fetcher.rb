module Feedjira
  class Fetcher
    def self.fetch(*args)
      new(*args).fetch
    end

    attr_reader :url, :conn

    def initialize(url, conn=Faraday.new)
      @url = url
      @conn = conn
    end

    def fetch
      response = conn.get url
      response.body
    end
  end
end
