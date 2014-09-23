# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'heartbeat_abril/version'

Gem::Specification.new do |spec|
  spec.name          = "heartbeat_abril"
  spec.version       = HeartbeatAbril::VERSION
  spec.authors       = ["Diogo Scudelletti"]
  spec.email         = ["diogo@scudelletti.com"]
  spec.summary       = %q{Builds a heartbeat route for Abril Apps}
  spec.description   = %q{Builds a heartbeat route for Abril Apps}
  spec.homepage      = ""
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
  spec.add_development_dependency "pry-nav", "~> 0.2.4"
end
