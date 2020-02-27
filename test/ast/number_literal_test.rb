require File.expand_path('../test_helper.rb', File.dirname(__FILE__))

module Ast
  class NumberLiteralTest < Test::Unit::TestCase
    def test_to_decimal
      assert_equal(OracleSqlParser::Ast::NumberLiteral[:value => "5"].to_decimal, BigDecimal('5'))
      assert_equal(OracleSqlParser::Ast::NumberLiteral[:value => "5.5"].to_decimal, BigDecimal('5.5'))
    end
  end
end

