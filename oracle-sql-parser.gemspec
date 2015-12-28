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

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.files         += `echo lib/oracle-sql-parser/grammar/*.rb`.split(" ")
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 1.9.0'
  spec.add_dependency "bundler", "~> 1.10"
  spec.add_dependency "rake", "~> 10.0"
  spec.add_dependency "test-unit", "~> 3.1"
  spec.add_dependency "treetop", "~> 1.6"
  spec.add_development_dependency "pry-byebug"
end
