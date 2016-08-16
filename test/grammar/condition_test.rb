require File.expand_path('base_test.rb', File.dirname(__FILE__))

module Grammar
  class ConditionTest < BaseTest
    def test_select_where_parseable
      assert_ast_sql_equal "select * from table1 where col1 = col1",
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
                :condition => Ast::SimpleComparisonCondition[
                  :left => Ast::Identifier[:name => 'col1'],
                  :op => '=',
                  :right => Ast::Identifier[:name => 'col1']
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_where_with_literal_textparseable
      assert_ast_sql_equal "select * from table1 where col1 = 'abc'",
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
                :condition => Ast::SimpleComparisonCondition[
                  :left => Ast::Identifier[:name => 'col1'],
                  :op => '=',
                  :right => Ast::TextLiteral[:value => 'abc']
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_where_with_literal_number_parseable
      assert_ast_sql_equal "select * from table1 where col1 = -1",
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
                :condition => Ast::SimpleComparisonCondition[
                  :left => Ast::Identifier[:name => 'col1'],
                  :op => '=',
                  :right => Ast::NumberLiteral[:value => '-1']
                ]
              ]
            ]
          ]
        ]
    end
  end
end
