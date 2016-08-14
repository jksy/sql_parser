require File.expand_path('base_test.rb', File.dirname(__FILE__))

module Grammar
  class ConditionFloatingPointTest < BaseTest
    def test_select_where_floating_point_condition_nan_parseable
      assert_ast_sql_equal "select * from table1 where col1 is nan",
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
                :condition => Ast::FloatingPointCondition[
                  :target => Ast::Identifier[:name => 'col1'],
                  :is => Ast::Keyword[:name => 'is'],
                  :value => Ast::Keyword[:name => 'nan'],
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_where_floating_point_condition_with_not_parseable
      assert_ast_sql_equal "select * from table1 where col1 is not nan",
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
                :condition => Ast::FloatingPointCondition[
                  :target => Ast::Identifier[:name => 'col1'],
                  :is => Ast::Keyword[:name => 'is'],
                  :not => Ast::Keyword[:name => 'not'],
                  :value => Ast::Keyword[:name => 'nan'],
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_where_floating_point_condition_infinit_parseable
      assert_ast_sql_equal "select * from table1 where col1 is not infinite",
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
                :condition => Ast::FloatingPointCondition[
                  :target => Ast::Identifier[:name => 'col1'],
                  :is => Ast::Keyword[:name => 'is'],
                  :not => Ast::Keyword[:name => 'not'],
                  :value => Ast::Keyword[:name => 'infinite'],
                ]
              ]
            ]
          ]
        ]
    end


  end
end
