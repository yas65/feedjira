module Feedjira
  module FeedEntryUtilities
    def [](field)
      self.instance_variable_get("@#{field.to_s}")
    end

    def []=(field, value)
      self.instance_variable_set("@#{field.to_s}", value)
    end
  end
end
