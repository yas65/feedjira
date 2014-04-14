require 'spec_helper'

describe Feedjira::Parser do
  let(:xml) { sample_atom_feed }

  it 'parses' do
    feed = Feedjira::Parser.parse xml
    expect(feed).to be_a Feedjira::Parser::Atom
  end
end
