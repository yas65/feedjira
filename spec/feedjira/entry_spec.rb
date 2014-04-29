require 'spec_helper'

describe Feedjira::Entry do
  def fragment(opts={})
    double({author: nil,
            categories: nil,
            content: nil,
            entry_id: nil,
            image: nil,
            published: nil,
            updated: nil,
            summary: nil,
            title: nil,
            url: nil}.merge(opts))
  end

  describe "sanitizing" do
    context "with an unsafe attribute" do
      it "leaves nils alone" do
        entry = Feedjira::Entry.new fragment(image: nil)
        expect(entry.image).to be_nil
      end

      it "scrubs unsafe html" do
        author = "author<script>unsafe</script>"
        entry = Feedjira::Entry.new fragment(author: author)
        expect(entry.author).to eq 'author'
      end

      it "preserves safe html" do
        title = "<p>title</p><script>unsafe</script>"
        entry = Feedjira::Entry.new fragment(title: title)
        expect(entry.title).to eq '<p>title</p>'
      end

      it "trims excess whitespace" do
        content = " <p>content stuff</p> <script>unsafe</script>"
        entry = Feedjira::Entry.new fragment(content: content)
        expect(entry.content).to eq '<p>content stuff</p>'
      end
    end

    context "with unsafe categories" do
      it "should provide sanitized categories" do
        categories = ["category <script>this is not safe</script>"]
        entry = Feedjira::Entry.new fragment(categories: categories)
        expect(entry.categories).to eq ['category']
      end
    end
  end

  describe "date parsing" do
    it "parses ISO 8601 formatted datetimes into Time" do
      published = "2008-02-20T8:05:00-010:00"
      entry = Feedjira::Entry.new fragment(published: published)
      expect(entry.published).to eq(Time.parse("Wed Feb 20 18:05:00 UTC 2008"))
    end

    it "parses ISO 8601 with milliseconds into Time" do
      published = "2013-09-17T08:20:13.931-04:00"
      entry = Feedjira::Entry.new fragment(published: published)
      expect(entry.published).to eq(Time.parse("Tue Sep 17 12:20:13.931 UTC 2013"))
    end

    it "returns Times at UTC offset" do
      published = Time.parse "2014-03-17T04:00:00-05:00"
      entry = Feedjira::Entry.new fragment(published: published)
      expect(entry.published).to eq(Time.parse("Wed Mar 17 09:00:00 UTC 2014"))
    end

    it "returns nil with an unparsable datetime" do
      published = "hello"
      entry = Feedjira::Entry.new fragment(published: published)
      expect(entry.published).to be_nil
    end
  end
end
