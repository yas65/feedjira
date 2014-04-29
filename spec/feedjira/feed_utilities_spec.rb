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

  describe "instance methods" do
    it "should provide an etag accessor" do
      feed = @klass.new
      feed.etag = "foo"
      feed.etag.should == "foo"
    end

    it "should provide a last_modified accessor" do
      feed = @klass.new
      time = Time.now
      feed.last_modified = time
      feed.last_modified.should == time
      feed.last_modified.class.should == Time
    end

    it "should return a last_modified value from the entry with the most recent published date if the last_modified date hasn't been set" do
      feed = Feedjira::Parser::Atom.new
      entry =Feedjira::Parser::AtomEntry.new
      entry.published = Time.now.to_s
      feed.entries << entry
      feed.last_modified.should == entry.published
    end

    it "should not throw an error if one of the entries has published date of nil" do
      feed = Feedjira::Parser::Atom.new
      entry = Feedjira::Parser::AtomEntry.new
      entry.published = Time.now.to_s
      feed.entries << entry
      feed.entries << Feedjira::Parser::AtomEntry.new
      feed.last_modified.should == entry.published
    end
  end
end
