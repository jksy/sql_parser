require File.expand_path('../test_helper.rb', File.dirname(__FILE__))

module Ast
  class TextLiteralTest < Test::Unit::TestCase
    def test_to_s
      assert_equal(OracleSqlParser::Ast::TextLiteral[:value => "asdf"].to_s, 'asdf')
    end
  end
end
