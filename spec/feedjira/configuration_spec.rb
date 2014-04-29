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

  describe '#user_agent' do
    let(:configuration) { Feedjira::Configuration.new }
    let(:user_agent) { configuration.user_agent }

    it 'returns the default user agent' do
      expect(user_agent).to match /Feedjira v.* http:\/\/feedjira.com/
    end

    it 'can be configured' do
      configuration.user_agent = 'MyApp'
      expect(user_agent).to eq 'MyApp'
    end
  end
end
