require 'simplecov'
require 'simplecov-cobertura'
SimpleCov.start do
  # test:unit and test:adapter run in separate processes; give each a name so
  # SimpleCov merges their results instead of overwriting them. The Rakefile
  # sets SIMPLECOV_COMMAND_NAME per task.
  command_name ENV.fetch('SIMPLECOV_COMMAND_NAME', 'unit')
  enable_coverage :branch

  if ENV['CI']
    formatter SimpleCov::Formatter::CoberturaFormatter
  else
    formatter SimpleCov::Formatter::MultiFormatter.new([
                SimpleCov::Formatter::SimpleFormatter,
                SimpleCov::Formatter::HTMLFormatter
              ])
  end

  skip "/test/"
  skip "/vendor/"

  # Parsers generated from .treetop files dominate the line count, so keep
  # them apart from the hand-written code in the report (see codecov.yml).
  add_group "Generated parsers" do |src|
    src.filename.include?("/lib/oracle-sql-parser/grammar/") &&
      File.exist?(src.filename.sub(/\.rb\z/, ".treetop"))
  end
  add_group "Hand-written" do |src|
    !(src.filename.include?("/lib/oracle-sql-parser/grammar/") &&
      File.exist?(src.filename.sub(/\.rb\z/, ".treetop")))
  end
end

require 'test/unit'
require 'test/unit/assertions'
require 'colorize'
lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'oracle-sql-parser'
require "#{File.expand_path('./', File.dirname(__FILE__))}/parse_testable.rb"

module Test::Unit::Assertions
  AssertionMessage.max_diff_target_string_size = 10000

  def assert_ast_equal(expect, actual, message = nil)
    difference = nil
    full_message = nil
    difference = AssertionMessage.delayed_diff(expect.to_s, actual.to_s)
    full_message = build_message(message, <<EOS, expect, actual, difference)
<?> expected but was
<?>.?
EOS

    assert_block(full_message) do
      expect == actual
    end
  end
end

