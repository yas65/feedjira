module Feedjira
  class Parser
    class Rss
      include SAXMachine
      include FeedUtilities

      element :rss, as: :version, value: :version
      element :title
      element :description
      element :link, as: :url
      elements :item, as: :entries, class: RssEntry

      attr_accessor :feed_url
      attr_accessor :hubs

      def self.able_to_parse?(xml)
        (/\<rss|\<rdf/ =~ xml) && !(/feedburner/ =~ xml)
      end
    end
  end
end
