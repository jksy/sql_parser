require File.expand_path('base_test.rb', File.dirname(__FILE__))

module Grammar
  class ConditionCompoundTest < BaseTest
    def test_select_where_with_compound_conditions_parseable
      assert_ast_sql_equal "select * from table1 where (col1 = col2)",
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
                :condition => Ast::CompoundCondition[
                  :condition => Ast::SimpleComparisonCondition[
                      :left => Ast::Identifier[:name => 'col1'],
                      :op => '=',
                      :right => Ast::Identifier[:name => 'col2']
                  ]
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_where_with_compound_not_conditions_parseable
      assert_ast_sql_equal "select * from table1 where not col1 = col2",
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
                :condition => Ast::LogicalCondition[
                  :op => Ast::Keyword[:name => 'not'],
                  :right => Ast::SimpleComparisonCondition[
                    :left => Ast::Identifier[:name => 'col1'],
                    :op => '=',
                    :right => Ast::Identifier[:name => 'col2']
                  ]
                ]
              ]
            ]
          ]
        ]
    end
  end
end
