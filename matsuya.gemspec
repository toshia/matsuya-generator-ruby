# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'matsuya/version'

Gem::Specification.new do |spec|
  spec.name          = "matsuya"
  spec.version       = Matsuya::VERSION
  spec.authors       = ["Toshiaki Asai"]
  spec.email         = ["toshi.alternative@gmail.com"]
  spec.summary       = "I'm hungry. gyu-meshi! gyu-meshi!"
  spec.description   = "Generate Okanic Matsuya food."
  spec.homepage      = "https://github.com/toshia/matsuya-generator-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = 'matsuya'
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 3.0'

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
end
