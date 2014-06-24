$:.push File.expand_path("../lib", __FILE__)
require 'suds/version'

Gem::Specification.new do |s|
  s.name        = 'suds'
  s.version     = Suds::VERSION
  s.licenses    = ['MIT']
  s.summary     = "Interpret, clean, and convert lists."
  s.description = "Suds is a versatile list manipulation library/dsl. It's meant to interpret various difference formats, apply mutations, and then export to various formats."
  s.authors     = ["Uri Gorelik"]
  s.email       = 'uri@healthwave.co'
  s.files       = `git ls-files`.split("\n")
  s.homepage    = 'https://healthwave.co/'
  s.require_paths = ["lib"]
end
