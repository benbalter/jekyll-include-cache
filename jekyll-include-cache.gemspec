# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("lib", __dir__)
require "jekyll-include-cache/version"

Gem::Specification.new do |s|
  s.name          = "jekyll-include-cache"
  s.version       = JekyllIncludeCache::VERSION
  s.authors       = ["Ben Balter"]
  s.email         = ["ben.balter@github.com"]
  s.homepage      = "https://github.com/benbalter/jekyll-include-cache"
  s.summary       = "A Jekyll plugin to cache the rendering of Liquid includes"

  s.files         = `git ls-files app lib`.split("\n")
  s.platform      = Gem::Platform::RUBY
  s.require_paths = ["lib"]
  s.license       = "MIT"

  s.add_dependency "jekyll", ">= 3.7", "< 5.0"
  s.add_development_dependency "rspec", "~> 3.5"
  s.add_development_dependency "rubocop", "~> 1.0"
  s.add_development_dependency "rubocop-jekyll", "~> 0.3"
  s.add_development_dependency "rubocop-performance", "~> 1.5"
  s.add_development_dependency "rubocop-rspec", "~> 3.0"
  # No longer default gems as of recent Rubies; required transitively by
  # RuboCop and Jekyll's dependencies (e.g. safe_yaml needs base64 on Ruby
  # 3.4+, RuboCop needs benchmark/ostruct on Ruby 4.0).
  s.add_development_dependency "base64"
  s.add_development_dependency "benchmark"
  s.add_development_dependency "ostruct"
  s.add_development_dependency "tsort"

  s.required_ruby_version = ">= 3.0"
end
