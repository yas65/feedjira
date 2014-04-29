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
end
