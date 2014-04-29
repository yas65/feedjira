require 'spec_helper'

describe Feedjira::Parser do
  describe '#parse' do
    subject(:parser) { Feedjira::Parser.new xml }

    context 'with Atom xml' do
      let(:xml) { sample_atom_feed }

      it 'returns an Atom parsed document' do
        expect(parser.parse).to be_a Feedjira::Parser::Atom
      end
    end

    context 'with RSS xml' do
      let(:xml) { sample_rss_feed }

      it 'returns an RSS parsed document' do
        expect(parser.parse).to be_a Feedjira::Parser::Rss
      end
    end

    context "with xml that can't be parsed" do
      let(:xml) { '<xml></xml>' }

      it 'raises an error' do
        expect { parser.parse }.to raise_error Feedjira::Parser::ParserNotFoundError
      end
    end

    context 'with a supplied parser' do
      subject(:parser) { Feedjira::Parser.new xml, parser: my_parser }
      let(:xml) { sample_atom_feed }
      let(:my_parser) { Class.new }

      it 'uses that parser' do
        my_parser.should_receive(:parse)
        parser.parse
      end
    end
  end
end
