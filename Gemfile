# frozen_string_literal: true

source 'https://rubygems.org'

# Specify your gem's dependencies in oracle-sql-parser.gemspec
gemspec

gem 'appraisal'
gem 'colorize'
gem 'pry-byebug'
gem 'rake', '~> 13.0'
gem 'rubocop', '~> 1.91'
gem 'test-unit', '~> 3.5'

group :test do
  gem 'simplecov', '>= 1.0', require: false # SimpleCov.skip needs 1.0+
  gem 'simplecov-cobertura', require: false
end

# Gems for the Oracle connection tests (test/oracle_enhanced-adapter) are
# declared in Appraisals, not here, so a plain `bundle install` works without
# Oracle Instant Client. See README "Development".
