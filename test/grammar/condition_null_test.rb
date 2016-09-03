require File.expand_path('base_test.rb', File.dirname(__FILE__))

module Grammar
  class ConditionNullTest < BaseTest
    def test_select_where_with_null_conditions_parseable
      assert_ast_sql_equal "select * from table1 where col1 is null",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources =>  Ast::Array[
                Ast::TableReference[
                  :table_name => Ast::Identifier[:name => 'table1']
                ]
              ],
              :where_clause => Ast::WhereClause[
                :condition => Ast::NullCondition[
                  :target => Ast::Identifier[:name => 'col1']
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_where_with_not_null_conditions_parseable
      assert_ast_sql_equal "select * from table1 where col1 is not null",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources =>  Ast::Array[
                Ast::TableReference[
                  :table_name => Ast::Identifier[:name => 'table1']
                ]
              ],
              :where_clause => Ast::WhereClause[
                :condition => Ast::NullCondition[
                  :target => Ast::Identifier[:name => 'col1'],
                  :not => Ast::Keyword[:name => 'not']
                ]
              ]
            ]
          ]
        ]
    end
  end
end

