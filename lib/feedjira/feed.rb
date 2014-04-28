module Feedjira
  class Feed
    attr_reader :title, :description, :url, :entries, :doc

    def initialize(doc)
      @doc = doc
      @title = doc.title
      @description = doc.description
      @url = doc.url
      @entries = doc.entries
    end
  end
end
