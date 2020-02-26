require File.expand_path('base_test.rb', File.dirname(__FILE__))
module Grammar
  class SelectRowLimitTest < BaseTest
    def test_select_row_limit
      assert_ast_sql_equal "select * from table1 fetch first 4 rows only",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => generate_ast("select * from table1").subquery.query_block,
            :row_limiting_clause => Ast::RowLimitingClause[
              :fetch => OracleSqlParser::Ast::Hash[
                :fetch_keyword => 'fetch',
                :first_keyword => 'first',
                :rowcount => OracleSqlParser::Ast::NumberLiteral[:value => 4],
                :rows_keyword => 'rows',
                :only_keyword => 'only',
              ]
            ]
          ]
        ]
    end
  end
end
