require 'kreator'

use Rack::Reloader, 0
use Rack::Auth::Basic do |username, password|
  password == 'password'
end

run Rack::Cascade.new([Rack::File.new("public"), Kreator])
