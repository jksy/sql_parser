require File.expand_path('base_test.rb', File.dirname(__FILE__))

module Grammar
  class ConditionComparisonTest < BaseTest

    def test_select_where_with_neq1_parseable
      assert_ast_sql_equal "select * from table1 where col1 != 1",
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
                :condition => Ast::SimpleComparisionCondition[
                  :left => Ast::Identifier[:name => 'col1'],
                  :op => '!=',
                  :right => Ast::NumberLiteral[:value => '1']
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_where_with_neq2_parseable
      assert_ast_sql_equal "select * from table1 where col1 ^= 1",
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
                :condition => Ast::SimpleComparisionCondition[
                  :left => Ast::Identifier[:name => 'col1'],
                  :op => '^=',
                  :right => Ast::NumberLiteral[:value => '1']
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_where_with_neq3_parseable
      assert_ast_sql_equal "select * from table1 where col1 <> 1",
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
                :condition => Ast::SimpleComparisionCondition[
                  :left => Ast::Identifier[:name => 'col1'],
                  :op => '<>',
                  :right => Ast::NumberLiteral[:value => '1']
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_where_with_less_equal_parseable
      assert_ast_sql_equal "select * from table1 where col1 <= 1",
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
                :condition => Ast::SimpleComparisionCondition[
                  :left => Ast::Identifier[:name => 'col1'],
                  :op => '<=',
                  :right => Ast::NumberLiteral[:value => '1']
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_where_with_grater_equal_parseable
      assert_ast_sql_equal "select * from table1 where col1 >= 1",
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
                :condition => Ast::SimpleComparisionCondition[
                  :left => Ast::Identifier[:name => 'col1'],
                  :op => '>=',
                  :right => Ast::NumberLiteral[:value => '1']
                ]
              ]
            ]
          ]
        ]
    end

  end
end
