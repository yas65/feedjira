require 'spec_helper'

describe Feedjira::FeedUtilities do
  before(:each) do
    @klass = Class.new do
      include Feedjira::FeedEntryUtilities
    end
  end

  describe "handling dates" do
    it "should parse an ISO 8601 formatted datetime into Time" do
      time = @klass.new.parse_datetime("2008-02-20T8:05:00-010:00")
      time.class.should == Time
      time.should == Time.parse_safely("Wed Feb 20 18:05:00 UTC 2008")
    end

    it "should parse a ISO 8601 with milliseconds into Time" do
      time = @klass.new.parse_datetime("2013-09-17T08:20:13.931-04:00")
      time.class.should == Time
      time.should == Time.parse_safely("Tue Sep 17 12:20:13 UTC 2013")
    end
  end
end
