# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'halyuken/version'

Gem::Specification.new do |spec|
  spec.name          = "halyuken"
  spec.version       = Halyuken::VERSION
  spec.authors       = ["Michael Granados"]
  spec.email         = ["michaelgranados@gmail.com"]
  spec.summary       = %q{JSON+HAL easy for Rails}
  spec.description   = %q{Generate simple json+hal responses for Rails Framework}
  spec.homepage      = "http://valepresente.github.io/halyuken"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'halibut', '~> 0.5'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
end
