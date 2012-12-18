require 'rake'
require 'rake/testtask'

# Dir["#{File.dirname(__FILE__)}/tasks/**/*.rake"].sort.each { |t| load t }

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end

task "db:seed", "Setup database" do
  load File.expand_path('../db/seed.rb', __FILE__)
end

task :default => "test"
