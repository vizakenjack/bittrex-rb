# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bittrex/version'

Gem::Specification.new do |spec|
  spec.name          = 'bittrex-rb'
  spec.version       = Bittrex::VERSION
  spec.authors       = ['Vizakenjack']
  spec.email         = ['vizakenjack@gmail.com']
  spec.description   = %q{Ruby Bittrex.com client}
  spec.summary       = %q{Working with API}
  spec.homepage      = 'https://github.com/Vizakenjack/bittrex-rb'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rake', '~> 12.3'

  spec.add_runtime_dependency 'json', '~> 2.1'
  spec.add_runtime_dependency 'httparty', '~> 0.16'
end
