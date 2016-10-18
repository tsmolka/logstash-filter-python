@files=[]

task :default do
  system("rake -T")
end

require "logstash/devutils/rake"

desc "run specs"
task :spec do
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new
end
