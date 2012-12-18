require File.expand_path('../config/application', __FILE__)

use Rack::Reloader, 0
run Rack::Cascade.new([Rack::File.new("public"), Kreator])
