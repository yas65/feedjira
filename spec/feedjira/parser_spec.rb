require 'spec_helper'

describe Feedjira::Parser do
  let(:xml) { sample_atom_feed }

  it 'parses' do
    feed = Feedjira::Parser.parse xml
    expect(feed).to be_a Feedjira::Parser::Atom
  end

  context "with xml that can't be parsed" do
    it 'raises an error' do
      expect do
        Feedjira::Parser.parse '<xml></xml>'
      end.to raise_error Feedjira::Parser::ParserNotFoundError
    end
  end
end
