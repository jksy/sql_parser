require File.expand_path('base_test.rb', File.dirname(__FILE__))

module Grammar
  class ConditionBetweenTest < BaseTest
    def test_select_where_with_between_conditions_parseable
      assert_ast_sql_equal "select * from table1 where col1 between col2 and col3",
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
                :condition => Ast::BetweenCondition[
                  :target => Ast::Identifier[:name => 'col1'],
                  :from => Ast::Identifier[:name => 'col2'],
                  :to => Ast::Identifier[:name => 'col3']
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_where_with_not_between_conditions_parseable
      assert_ast_sql_equal "select * from table1 where col1 not between col2 and col3",
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
                :condition => Ast::BetweenCondition[
                  :target => Ast::Identifier[:name => 'col1'],
                  :not => Ast::Keyword[:name => 'not'],
                  :from => Ast::Identifier[:name => 'col2'],
                  :to => Ast::Identifier[:name => 'col3']
                ]
              ]
            ]
          ]
        ]

    end

    def test_select_where_with_between_number_conditions_parseable
      assert_ast_sql_equal "select * from table1 where col1 between 1 and 100",
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
                :condition => Ast::BetweenCondition[
                  :target => Ast::Identifier[:name => 'col1'],
                  :from => Ast::NumberLiteral[:value => '1'],
                  :to => Ast::NumberLiteral[:value => '100']
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_where_with_between_string_conditions_parseable
      assert_ast_sql_equal "select * from table1 where col1 between 'a' and 'z'",
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
                :condition => Ast::BetweenCondition[
                  :target => Ast::Identifier[:name => 'col1'],
                  :from => Ast::TextLiteral[:value => 'a'],
                  :to => Ast::TextLiteral[:value => 'z']
                ]
              ]
            ]
          ]
        ]
    end
  end
end
