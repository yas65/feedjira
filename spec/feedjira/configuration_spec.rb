require 'spec_helper'

describe Feedjira::Configuration do
  describe '#parsers' do
    let(:configuration) { Feedjira::Configuration.new }
    let(:parsers) { configuration.parsers }

    it 'returns the default parser classes' do
      expect(parsers).to eq [Feedjira::Parser::Atom, Feedjira::Parser::Rss]
    end

    it 'can be configured' do
      parser = Class.new
      configuration.parsers = [parser]

      expect(parsers).to eq [parser]
    end
  end
end
