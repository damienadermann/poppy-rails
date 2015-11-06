# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'poppy/rails/version'

Gem::Specification.new do |spec|
  spec.name          = "poppy-rails"
  spec.version       = Poppy::Rails::VERSION
  spec.authors       = ["Damien Adermann"]
  spec.email         = ["damienadermann@gmail.com"]

  spec.summary       = %q{Ruby On Rails integration for Poppy Enumerations}
  spec.description   = %q{Simple Polymorphic enumerations for Ruby on Rails. Inspired by Enumerate_it, not inspired by ActiveRecord enum}
  spec.homepage      = "https://github.com/damienadermann/poppy-rails"
  spec.license       = "MIT"


  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "poppy", "0.1.0"
  spec.add_dependency "activerecord", "~> 4.2.0"

  spec.add_development_dependency "pg"
  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "byebug"
end
