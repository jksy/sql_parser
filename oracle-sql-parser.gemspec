# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'oracle-sql-parser/version'

Gem::Specification.new do |spec|
  spec.name          = "oracle-sql-parser"
  spec.version       = OracleSqlParser::VERSION
  spec.authors       = ["Junichiro Kasuya"]
  spec.email         = ["junichiro.kasuya@gmail.com"]

  spec.summary       = %q{SQL Parser for Oracle}
  spec.description   = %q{SQL Parser for Oracle}
  spec.homepage      = "https://github.com/jksy/sql_parser"
  spec.licenses      = ["MIT"]

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test)/|.travis}) }
  spec.files         += `echo lib/oracle-sql-parser/grammar/*.rb`.split(" ")
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 1.9.0'
  spec.add_runtime_dependency "treetop", "~> 1.6"
  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "test-unit", "~> 3.1"
  spec.add_development_dependency "activerecord", "~> 4.2"
  spec.add_development_dependency "activerecord-oracle_enhanced-adapter", "~> 1.6.0"
  spec.add_development_dependency "ruby-oci8", "~> 2.0"
  spec.add_development_dependency "pry-byebug", "3.4.0" if RUBY_VERSION >= '2.0.0'
  spec.add_development_dependency "colorize", "~> 0.8"
end
