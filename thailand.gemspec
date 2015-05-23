# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'thailand/version'

Gem::Specification.new do |spec|
  spec.name = 'thailand'
  spec.version = Thailand::VERSION
  spec.platform = Gem::Platform::RUBY
  spec.required_ruby_version = '>= 2.0'
  spec.authors = ['Chainarin Thanichaiyawat', 'Phuwanart Larpmark']
  spec.email = ['kiterminal@gmail.com', 'neokain@gmail.com']
  spec.summary = 'Provinces, districts and subdistricts of Thailand'
  spec.description = 'Provinces, districts and subdistricts of Thailand'
  spec.homepage = 'https://github.com/kiterminal/thailand'
  spec.license = 'MIT'
  spec.metadata = {}

  spec.files = `git ls-files`.split($RS).reject do |file|
    file =~ %r{^(?:
    |spec/.*
    |spec_data/.*
    |Gemfile
    |Rakefile
    |\.rspec
    |\.gitignore
    |\.rubocop.yml
    |\.rubocop_todo.yml
    |\.travis.yml
    |.*\.eps
    )$}x
  end
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files = []
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport', '~> 4.0'
  spec.add_development_dependency 'bundler', '~> 1.9'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.2'
  spec.add_development_dependency 'simplecov', '~> 0.10'
  spec.add_development_dependency 'coveralls', '~> 0.8'
end
