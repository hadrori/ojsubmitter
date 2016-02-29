# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ojsubmitter/version'

Gem::Specification.new do |spec|
  spec.name          = "ojsubmitter"
  spec.version       = OJS::VERSION
  spec.authors       = ["hadrori"]
  spec.email         = ["hadrori.hs@gmail.com"]

  spec.summary       = %q{This gem helps you to submit a source code to online judge.}
  spec.homepage      = "https://github.com/hadrori/ojsubmitter"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = ["ojsubmitter"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "simplecov", "~> 0.11.0"
  spec.add_development_dependency "coveralls", "~> 0.8.0"

  spec.add_dependency 'httpclient', '~> 2.7.0'
  spec.add_dependency 'thor', '~> 0.19.0'
end
