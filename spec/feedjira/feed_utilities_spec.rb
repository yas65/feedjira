require File.dirname(__FILE__) + '/../spec_helper'

describe Feedjira::FeedUtilities do
  before(:each) do
    @klass = Class.new do
      include SAXMachine
      include Feedjira::FeedUtilities
    end
  end

  describe "preprocessing" do
    context "when the flag is not set" do
      it "does not call the preprocessing method" do
        @klass.preprocess_xml = false
        @klass.should_not_receive :preprocess
        @klass.parse sample_rss_feed
      end
    end

    context "when the flag is set" do
      it "calls the preprocessing method" do
        @klass.preprocess_xml = true
        @klass.should_receive(:preprocess).
          and_return sample_rss_feed
        @klass.parse sample_rss_feed
      end
    end
  end
end
