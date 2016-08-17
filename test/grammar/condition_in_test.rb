require File.expand_path('base_test.rb', File.dirname(__FILE__))

module Grammar
  class ConditionInTest < BaseTest
    def test_select_where_in_expr_condition_parseable
      assert_ast_sql_equal "select * from table1 where col1 in (1)",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name => Ast::Identifier[:name => 'table1']
                ]
              ],
              :where_clause => Ast::WhereClause[
                :condition => Ast::InCondition[
                  :target => Ast::Identifier[:name => 'col1'],
                  :values => Ast::Array[
                    Ast::NumberLiteral[:value => '1']
                  ]
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_where_not_in_expr_condition_parseable
      assert_ast_sql_equal "select * from table1 where col1 not in (1)" ,
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name => Ast::Identifier[:name => 'table1']
                ]
              ],
              :where_clause => Ast::WhereClause[
                :condition => Ast::InCondition[
                  :target => Ast::Identifier[:name => 'col1'],
                  :not => Ast::Keyword[:name => 'not'],
                  :values => Ast::Array[
                    Ast::NumberLiteral[:value => '1']
                  ]
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_where_in_subquery_condition_parseable
      assert_ast_sql_equal "select * from table1 where col1 in (select * from table2)",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name =>Ast::Identifier[:name => 'table1']
                ]
              ],
              :where_clause => Ast::WhereClause[
                :condition => Ast::InCondition[
                  :target => Ast::Identifier[:name => 'col1'],
                  :values => generate_ast("select * from table2").subquery
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_where_not_in_subquery_condition_parseable
      assert_ast_sql_equal "select * from table1 where col1 not in (select * from table2)",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name => Ast::Identifier[:name => 'table1']
                ]
              ],
              :where_clause => Ast::WhereClause[
                :condition => Ast::InCondition[
                  :target => Ast::Identifier[:name => 'col1'],
                  :not => Ast::Keyword[:name => 'not'],
                  :values => generate_ast("select * from table2").subquery
                ]
              ]
            ]
          ]
        ]
    end
  end
end
