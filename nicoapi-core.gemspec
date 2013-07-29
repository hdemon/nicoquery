# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nicoapi/core/version'

Gem::Specification.new do |spec|
  spec.name          = "nicoapi-core"
  spec.version       = Nicoapi::VERSION
  spec.authors       = ["Masami Yonehara"]
  spec.email         = ["zeitdiebe@gmail.com"]
  spec.description   = %q{niconico low level api library}
  spec.summary       = %q{niconico low level api library}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rest-client"
  spec.add_runtime_dependency "active_support"
  spec.add_runtime_dependency "i18n"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "watchr"
  spec.add_development_dependency "pry"
end
