require File.expand_path('base_test.rb', File.dirname(__FILE__))
module Grammar
  class SelectRowLimitTest < BaseTest
    def test_select_row_limit
      assert_ast_sql_equal "select * from table1 fetch first 4 rows only",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => generate_ast("select * from table1").subquery.query_block,
            :row_limiting_clause => Ast::RowLimitingClause[
              :fetch => OracleSqlParser::Ast::Fetch[
                :fetch => Ast::Keyword[:name => 'fetch'],
                :first => Ast::Keyword[:name => 'first'],
                :rowcount => OracleSqlParser::Ast::NumberLiteral[:value => '4'],
                :rows => Ast::Keyword[:name => 'rows'],
                :only => Ast::Keyword[:name => 'only'],
              ]
            ]
          ]
        ]
    end

    def test_select_row_limit
      assert_ast_sql_equal "select * from table1 offset 10 rows fetch first 4 rows only",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => generate_ast("select * from table1").subquery.query_block,
            :row_limiting_clause => Ast::RowLimitingClause[
              :fetch => OracleSqlParser::Ast::Fetch[
                :fetch => Ast::Keyword[:name => 'fetch'],
                :first => Ast::Keyword[:name => 'first'],
                :rowcount => OracleSqlParser::Ast::NumberLiteral[:value => '4'],
                :rows => Ast::Keyword[:name => 'rows'],
                :only => Ast::Keyword[:name => 'only'],
              ]
            ]
          ]
        ]
    end
  end
end
