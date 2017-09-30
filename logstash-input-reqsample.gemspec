Gem::Specification.new do |s|
  s.name          = 'logstash-input-reqsample'
  s.version       = '0.1.0'
  s.licenses      = ['Apache License (2.0)']
  s.summary       = 'Generate randomized log events.'
  s.description   = 'Generate randomized log events.'
  s.homepage      = 'https://rubygems.org/gems/reqsample'
  s.authors       = ['Tyler Langlois']
  s.email         = 'tjl@byu.net'
  s.require_paths = ['lib']

  # Files
  s.files = Dir[
    'lib/**/*',
    'spec/**/*',
    'vendor/**/*',
    '*.gemspec',
    '*.md',
    'CONTRIBUTORS',
    'Gemfile',
    'LICENSE',
    'NOTICE.TXT'
  ]

  # Tests
  s.test_files = s.files.grep(%r{^(test|spec|features)/})

  # Special flag to let us know this is actually a logstash plugin
  s.metadata = { 'logstash_plugin' => 'true', 'logstash_group' => 'input' }

  # Gem dependencies
  s.add_runtime_dependency 'chronic', '~> 0.10.2'
  s.add_runtime_dependency 'logstash-core-plugin-api', '~> 2.0'
  s.add_runtime_dependency 'logstash-codec-plain'
  s.add_runtime_dependency 'reqsample', '~> 0.0.2'
  s.add_runtime_dependency 'stud', '>= 0.0.22'
  s.add_development_dependency 'logstash-devutils'
end
