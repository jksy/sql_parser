require File.expand_path('../test_helper.rb', File.dirname(__FILE__))

module Ast
  class ReplaceLiteralTest < Test::Unit::TestCase
    include ParseTestable

    def test_delete_parseable
      ast = generate_ast("select 5,4,3,2 from table1")
      parameternized = ast.to_parameternized
      assert_equal(parameternized.to_sql, "select :a0,:a1,:a2,:a3 from table1")
      assert_equal(parameternized.params, {
        'a0' => OracleSqlParser::Ast::NumberLiteral[:value => "5"],
        'a1' => OracleSqlParser::Ast::NumberLiteral[:value => "4"],
        'a2' => OracleSqlParser::Ast::NumberLiteral[:value => "3"],
        'a3' => OracleSqlParser::Ast::NumberLiteral[:value => "2"],
        })
    end
  end
end

