# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'naturally-unicode/version'

Gem::Specification.new do |gem|
  gem.name          = "naturally-unicode"
  gem.version       = NaturallyUnicode::VERSION
  gem.authors       = ["Robb Shecter"]
  gem.email         = ["robb@weblaws.org"]
  gem.summary       = %q{Sorts numbers according to the way people are used to seeing them.}
  gem.description   = %q{Natural Sorting with support for legal numbering and unicode characters}
  gem.homepage      = "https://github.com/Loriowar/naturally-unicode"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
