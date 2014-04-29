require 'spec_helper'

describe Feedjira::Parser do
  describe '#parse' do
    subject(:parser) { Feedjira::Parser.new xml }

    context "with xml that can't be parsed" do
      let(:xml) { '<xml></xml>' }

      it 'raises an error' do
        expect { parser.parse }.to raise_error Feedjira::ParserNotFoundError
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
