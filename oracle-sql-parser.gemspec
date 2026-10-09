# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'oracle-sql-parser/version'

Gem::Specification.new do |spec|
  spec.name          = 'oracle-sql-parser'
  spec.version       = OracleSqlParser::VERSION
  spec.authors       = ['Junichiro Kasuya']
  spec.email         = ['junichiro.kasuya@gmail.com']

  spec.summary       = 'SQL Parser for Oracle'
  spec.description   = 'SQL Parser for Oracle'
  spec.homepage      = 'https://github.com/jksy/sql_parser'
  spec.licenses      = ['MIT']

  # Everything tracked by git except tests and repository tooling.
  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|\.github|\.claude|\.devcontainer|gemfiles)/}) ||
      f.match(/^(AGENTS\.md|CLAUDE\.md|Appraisals|codecov\.yml|Gemfile|\.gitignore|\.rubocop.*\.yml|\.ruby-version)$/)
  end
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 3.2.0'
  spec.metadata['rubygems_mfa_required'] = 'true'

  # bigdecimal is a bundled gem since Ruby 3.4 and must be declared explicitly
  spec.add_dependency 'bigdecimal'
  spec.add_dependency 'treetop', '~> 1.6'
end
