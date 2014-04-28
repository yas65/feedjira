module Feedjira
  class Entry
    attr_reader :author, :categories, :content, :entry_id,
      :image, :published, :summary, :title, :url, :fragment

    def initialize(fragment)
      @fragment = fragment
      @author = fragment.author
      @categories = fragment.categories
      @content = fragment.content
      @entry_id = fragment.entry_id
      @image = fragment.image
      @published = fragment.published
      @summary = fragment.summary
      @title = fragment.title
      @url = fragment.url
    end
  end
end
