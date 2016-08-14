require File.expand_path('base_test.rb', File.dirname(__FILE__))
module Grammar
  class SelectGroupTest < BaseTest
    def test_select_group_by_expr_parseable
      assert_ast_sql_equal(
        "select * from table1 group by col1,col2",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[:table_name => Ast::Identifier[:name => 'table1']],
              ],
              :group_by_clause => Ast::GroupByClause[
                :targets => Ast::Array[
                  Ast::Identifier[:name => 'col1'],
                  Ast::Identifier[:name => 'col2']
                ]
              ]
            ]
          ]
        ]
      )
    end

    def test_select_group_by_having_condition_parseable
      assert_ast_sql_equal(
        "select * from table1 group by col1,col2 having col1 = col2",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[:table_name => Ast::Identifier[:name => 'table1']],
              ],
              :group_by_clause => Ast::GroupByClause[
                :targets => Ast::Array[
                  Ast::Identifier[:name => 'col1'],
                  Ast::Identifier[:name => 'col2']
                ],
                :having => Ast::SimpleComparisionCondition[
                  :left => Ast::Identifier[:name => 'col1'],
                  :op => '=',
                  :right => Ast::Identifier[:name => 'col2']
                ]
              ]
            ]
          ]
        ]
      )
    end
  end
end
