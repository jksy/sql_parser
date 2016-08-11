require 'test/unit'
require 'test/unit/assertions'
require 'pry-byebug'
require 'colorize'
lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'oracle-sql-parser'
require "#{File.expand_path('./', File.dirname(__FILE__))}/parse_testable.rb"

module Test::Unit::Assertions
  AssertionMessage.max_diff_target_string_size = 10000 if RUBY_VERSION > '2.0.0'

  def assert_ast_equal(expect, actual, message = nil)
    difference = nil
    full_message = nil
    if RUBY_VERSION > '2.0.0'
      difference = AssertionMessage.delayed_diff(expect.to_s, actual.to_s) if RUBY_VERSION > '2.0.0'
      full_message = build_message(message, <<EOS, expect, actual, difference)
<?> expected but was
<?>.?
EOS
    else
      full_message = build_message(message, <<EOS, expect, actual)
<?> expected but was
<?>.?
EOS
    end

    assert_block(full_message) do
      expect == actual
    end
  end
end

