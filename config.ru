require 'kreator'

use Rack::Reloader, 0
use Rack::Static, :urls => ["/stylesheets"], :root => "public"

run Kreator.new
