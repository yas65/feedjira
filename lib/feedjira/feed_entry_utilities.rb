module Feedjira
  module FeedEntryUtilities
    include Enumerable

    def published
      @published ||= @updated
    end
    alias_method :last_modified, :published

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
