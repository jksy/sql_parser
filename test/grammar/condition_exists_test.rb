require File.expand_path('base_test.rb', File.dirname(__FILE__))

module Grammar
  class ConditionTest < BaseTest
    def test_select_where_with_exists_condition_parseable
      assert_ast_sql_equal "select * from table1 where exists (select 1 from table2)",
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
                :condition => Ast::ExistsCondition[
                  :target => generate_ast("select 1 from table2").subquery
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_where_with_not_exists_condition_parseable
      assert_ast_sql_equal "select * from table1 where not exists (select 1 from table2)",
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
                :condition => Ast::LogicalCondition[
                  :op => Ast::Keyword[:name => 'not'],
                  :right => Ast::ExistsCondition[
                    :target => generate_ast("select 1 from table2").subquery
                  ]
                ]
              ]
            ]
          ]
        ]
    end
  end
end
