module FaradayStubs
  def stubs
    Faraday::Adapter::Test::Stubs.new do |stub|
      stub.get('/blog/feed.xml') {[ 200, {}, sample_atom_middleman_feed ]}
    end
  end

  def conn
    Faraday.new do |b|
      b.adapter :test, stubs
    end
  end
end
