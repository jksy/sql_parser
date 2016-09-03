require File.expand_path('base_test.rb', File.dirname(__FILE__))
module Grammar
  class SelectOrderTest < BaseTest
    def test_select_order_by_clause_expr_parseable
      assert_ast_sql_equal "select * from table1 order by col1",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => generate_ast("select * from table1").subquery.query_block,
            :order_by_clause => Ast::OrderByClause[
              :items => Ast::Array[
                Ast::OrderByClauseItem[
                  :target => Ast::Identifier[:name => 'col1']
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_order_by_clause_position_parseable
      assert_ast_sql_equal "select * from table1 order by 1",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => generate_ast("select * from table1").subquery.query_block,
            :order_by_clause => Ast::OrderByClause[
              :items => Ast::Array[
                Ast::OrderByClauseItem[
                  :target => Ast::NumberLiteral[:value => '1']
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_order_by_clause_siblings_parseable
      assert_ast_sql_equal "select * from table1 order siblings by 1",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => generate_ast("select * from table1").subquery.query_block,
            :order_by_clause => Ast::OrderByClause[
              :siblings => Ast::Keyword[:name => 'siblings'],
              :items => Ast::Array[
                Ast::OrderByClauseItem[
                  :target => Ast::NumberLiteral[:value => '1']
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_order_by_clause_asc_parseable
      assert_ast_sql_equal "select * from table1 order by col1 asc",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => generate_ast("select * from table1").subquery.query_block,
            :order_by_clause => Ast::OrderByClause[
              :items => Ast::Array[
                Ast::OrderByClauseItem[
                  :target => Ast::Identifier[:name => 'col1'],
                  :asc => Ast::Keyword[:name => 'asc']
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_order_by_clause_desc_parseable
      assert_ast_sql_equal "select * from table1 order by col1 desc",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => generate_ast("select * from table1").subquery.query_block,
            :order_by_clause => Ast::OrderByClause[
              :items => Ast::Array[
                Ast::OrderByClauseItem[
                  :target => Ast::Identifier[:name => 'col1'],
                  :asc => Ast::Keyword[:name => 'desc']
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_order_by_clause_nulls_first_parseable
      assert_ast_sql_equal "select * from table1 order by col1 nulls first",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => generate_ast("select * from table1").subquery.query_block,
            :order_by_clause => Ast::OrderByClause[
              :items => Ast::Array[
                Ast::OrderByClauseItem[
                  :target => Ast::Identifier[:name => 'col1'],
                  :nulls => Ast::Keyword[:name => 'first']
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_order_by_clause_nulls_last_parseable
      assert_ast_sql_equal "select * from table1 order by col1 nulls last",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => generate_ast("select * from table1").subquery.query_block,
            :order_by_clause => Ast::OrderByClause[
              :items => Ast::Array[
                Ast::OrderByClauseItem[
                  :target => Ast::Identifier[:name => 'col1'],
                  :nulls => Ast::Keyword[:name => 'last']
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_order_by_clause_plural_column_parseable
      assert_ast_sql_equal "select * from table1 order by col1 asc,col2 desc",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => generate_ast("select * from table1").subquery.query_block,
            :order_by_clause => Ast::OrderByClause[
              :items => Ast::Array[
                Ast::OrderByClauseItem[
                  :target => Ast::Identifier[:name => 'col1'],
                  :asc => Ast::Keyword[:name => 'asc']
                ],
                Ast::OrderByClauseItem[
                  :target => Ast::Identifier[:name => 'col2'],
                  :asc => Ast::Keyword[:name => 'desc']
                ]
              ]
            ]
          ]
        ]
    end
  end
end
