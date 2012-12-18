require 'rake'
require 'rake/testtask'

path = '.'
$:.unshift(path) if File.directory?(path) && !$:.include?(path)

# Dir["#{File.dirname(__FILE__)}/tasks/**/*.rake"].sort.each { |t| load t }

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end

task :default => "test"
