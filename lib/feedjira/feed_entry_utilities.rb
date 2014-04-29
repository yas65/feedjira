module Feedjira
  module FeedEntryUtilities
    include Enumerable

    def published
      @published ||= @updated
    end
    alias_method :last_modified, :published

    ##
    # Returns the id of the entry or its url if not id is present, as some formats don't support it
    def id
      @entry_id ||= @url
    end

    def each
      @rss_fields ||= self.instance_variables

      @rss_fields.each do |field|
        yield(field.to_s.sub('@', ''), self.instance_variable_get(field))
      end
    end

    def [](field)
      self.instance_variable_get("@#{field.to_s}")
    end

    def []=(field, value)
      self.instance_variable_set("@#{field.to_s}", value)
    end
  end
end
