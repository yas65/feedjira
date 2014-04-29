module Feedjira
  module FeedUtilities
    UPDATABLE_ATTRIBUTES = %w(title feed_url url last_modified etag)

    attr_writer   :new_entries, :updated, :last_modified
    attr_accessor :etag

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def parse(xml, &block)
        xml = preprocess(xml) if preprocess_xml
        super xml.lstrip, &block
      end

      def preprocess(xml)
        # noop
        xml
      end

      def preprocess_xml=(value)
        @preprocess_xml = value
      end

      def preprocess_xml
        @preprocess_xml
      end
    end

    def last_modified
      return @last_modified if defined?(@last_modified)
      @last_modified = entries.map {|e| e.published }.compact.sort.last
    end
  end
end
