# setup bundler
require "bundler/setup"
Bundler.require

# setup load paths
path = File.expand_path('../lib', __FILE__)
$:.unshift(path) if File.directory?(path) && !$:.include?(path)

require 'kreator'

use Rack::Reloader, 0
use Rack::Auth::Basic do |username, password|
  password == 'password'
end

run Rack::Cascade.new([Rack::File.new("public"), Kreator])
