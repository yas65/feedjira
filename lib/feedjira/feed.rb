module Feedjira
  class Feed
    attr_reader :title, :description, :url, :entries, :doc

    def initialize(doc)
      @doc = doc
      @title = doc.title
      @description = doc.description
      @url = doc.url
      @entries = doc.entries.map { |e| Entry.new e }
    end

    def inspect
      sprintf('#<%s:0x%x @url="%s" @title="%s" ...>', self.class, object_id, @url, @title)
    end
  end
end
