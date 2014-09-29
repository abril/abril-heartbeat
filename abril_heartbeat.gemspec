# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'abril_heartbeat/version'

Gem::Specification.new do |spec|
  spec.name          = "abril_heartbeat"
  spec.version       = AbrilHeartbeat::VERSION
  spec.authors       = ["Diogo Scudelletti"]
  spec.email         = ["diogo@scudelletti.com"]
  spec.summary       = %q{Builds a heartbeat route for Apps}
  spec.description   = %q{This GEM is a middleware which adds a heartbeat route to your Apps, a route which checks your external dependencies such as MySQL, Mongo, Redis and REST APIs.}
  spec.homepage      = "https://github.com/abril/abril_heartbeat"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rack", "~> 1.4.5"
  spec.add_dependency "rest-client", "~> 1.7.2"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.1.0"
  spec.add_development_dependency "rack-test", "~> 0.6.2"
  spec.add_development_dependency "factory_girl", "~> 4.4.0"
  spec.add_development_dependency "vcr", "~> 2.9.3"
  spec.add_development_dependency "webmock", "~> 1.18.0"
  spec.add_development_dependency "pry-nav", "~> 0.2.4"
end
