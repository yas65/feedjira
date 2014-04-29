require 'loofah'
require 'time'

module Feedjira
  class Entry
    attr_reader :author, :categories, :content, :entry_id,
      :image, :published, :summary, :title, :updated, :url,
      :fragment

    def initialize(fragment)
      @fragment = fragment

      @entry_id  = fragment.entry_id
      @published = parse_datetime fragment.published
      @updated   = parse_datetime fragment.updated
      @url       = fragment.url

      @author  = scrub fragment.author
      @content = scrub fragment.content
      @image   = scrub fragment.image
      @summary = scrub fragment.summary
      @title   = scrub fragment.title
      @categories = (fragment.categories || []).map {|c| scrub c}
    end

    def inspect
      sprintf('#<%s:0x%x @url="%s" @title="%s" ...>', self.class, object_id, @url, @title)
    end

    def scrub(string)
      return unless string
      Loofah.scrub_fragment(string, :prune).to_s.strip
    end

    def parse_datetime(string)
      return string.utc if string.respond_to?(:utc)
      begin
        DateTime.parse(string).to_time.utc
      rescue => e
        nil
      end
    end
  end
end
