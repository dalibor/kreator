require 'minitest/autorun'
require File.expand_path('../../config/application', __FILE__)

describe Kreator do
  before do
    @request = Rack::MockRequest.new(Kreator)
  end

  it "returns 404 response for unknown requests" do
    @request.get("/unknown").status.must_equal 404
  end

  it "displays Hello world on landing page" do
    @request.get('/').body.must_include "Name"
  end
end
