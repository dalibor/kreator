require 'rubygems'
require 'rack'
require 'rspec'
require File.expand_path("../../lib/kreator", __FILE__)

describe Kreator do
  before do
    @request = Rack::MockRequest.new(Kreator)
  end

  it "returns 404 response for unknown requests" do
    @request.get("/unknown").status.should == 404
  end

  it "displays Hello world on landing page" do
    @request.get('/').body.should  include("You searched for")
  end
end
