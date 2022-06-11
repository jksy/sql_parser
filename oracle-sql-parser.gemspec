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
  spec.files         += `echo lib/oracle-sql-parser/grammar/**/*.rb`.split(" ")
  spec.files         += `echo lib/oracle-sql-parser/grammar/*.rb`.split(" ")
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.7.0'
  spec.add_runtime_dependency "treetop", "~> 1.6"
  spec.add_development_dependency "bundler", "~> 2.1"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "test-unit", "~> 3.5"
  spec.add_development_dependency "activerecord-oracle_enhanced-adapter", "~> 5.2.0"
  spec.add_development_dependency "ruby-oci8", "~> 2.0"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "colorize"
  spec.add_development_dependency "appraisal"
end
