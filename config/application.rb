require File.expand_path('../boot', __FILE__)

# setup load paths
path = File.expand_path('../lib', __FILE__)
$:.unshift(path) if File.directory?(path) && !$:.include?(path)

# require framework
KREATOR_ROOT = File.expand_path('../../.', __FILE__)
require 'kreator'
