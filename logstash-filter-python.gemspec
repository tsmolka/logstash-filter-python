raise "Only JRuby is supported" unless RUBY_PLATFORM == "java"

Gem::Specification.new do |s|

  s.name            = 'logstash-filter-python'
  s.version         = '0.0.1'
  s.licenses        = ['Apache License (2.0)']
  s.summary         = "Filter for executing python code on the event"
  s.description     = "This gem is a Logstash plugin required to be installed on top of the Logstash core pipeline using $LS_HOME/bin/logstash-plugin install gemname. This gem is not a stand-alone program"
  s.authors         = ["Tobias"]
  s.email           = 'tsmolka@gmail.com'
  s.homepage        = "https://github.com/tsmolka/logstash-filter-python"
  s.require_paths   = ["lib"]

  # Files
  s.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  
  # Tests
  s.test_files = `git ls-files -z`.split("\x0").reject { |f| !f.match(%r{^(test|spec|features)/}) }
  
  # Special flag to let us know this is actually a logstash plugin
  s.metadata = { "logstash_plugin" => "true", "logstash_group" => "filter" }

  s.platform = 'java'
  
  # Gem dependencies
  s.add_runtime_dependency "logstash-core-plugin-api", ">= 1.60", "<= 2.99"
  s.add_runtime_dependency "jruby-jython"
  
  s.add_development_dependency 'bundler', '~> 1.10'
  s.add_development_dependency 'rake', '~> 10.0'
  s.add_development_dependency 'rspec'
  
  s.add_development_dependency 'logstash-devutils'
end
