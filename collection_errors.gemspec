# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'collection_errors/version'

Gem::Specification.new do |spec|
  spec.name          = "collection_errors"
  spec.version       = CollectionErrors::VERSION
  spec.authors       = ["nay3"]
  spec.email         = ["y.ohba@everyleaf.com"]
  spec.description   = %q{Providing special validation error building for has_many collection in Rails.}
  spec.summary       = %q{Rails validation error extension}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
