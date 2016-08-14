require File.expand_path('base_test.rb', File.dirname(__FILE__))

module Grammar
  class ConditionPatternMachingTest < BaseTest
    def test_select_where_with_like_onditions_parseable
      assert_ast_sql_equal "select * from table1 where col1 like 'abc%'",
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
                :condition => Ast::LikeCondition[
                  :target => Ast::Identifier[:name => 'col1'],
                  :like => Ast::Keyword[:name => 'like'],
                  :text => Ast::TextLiteral[:value => 'abc%']
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_where_with_likec_onditions_parseable
      assert_ast_sql_equal "select * from table1 where col1 likec 'abc%'",
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
                :condition => Ast::LikeCondition[
                  :target => Ast::Identifier[:name => 'col1'],
                  :like => Ast::Keyword[:name => 'likec'],
                  :text => Ast::TextLiteral[:value => 'abc%']
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_where_with_like2_onditions_parseable
      assert_ast_sql_equal "select * from table1 where col1 like2 'abc%'",
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
                :condition => Ast::LikeCondition[
                  :target => Ast::Identifier[:name => 'col1'],
                  :like => Ast::Keyword[:name => 'like2'],
                  :text => Ast::TextLiteral[:value => 'abc%']
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_where_with_like4_onditions_parseable
      assert_ast_sql_equal "select * from table1 where col1 like4 'abc%'",
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
                :condition => Ast::LikeCondition[
                  :target => Ast::Identifier[:name => 'col1'],
                  :like => Ast::Keyword[:name => 'like4'],
                  :text => Ast::TextLiteral[:value => 'abc%']
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_where_with_not_like_onditions_parseable
      assert_ast_sql_equal "select * from table1 where col1 not like 'abc%'",
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
                :condition => Ast::LikeCondition[
                  :target => Ast::Identifier[:name => 'col1'],
                  :not => Ast::Keyword[:name => 'not'],
                  :like => Ast::Keyword[:name => 'like'],
                  :text => Ast::TextLiteral[:value => 'abc%']
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_where_with_like_escape_conditions_parseable
      assert_ast_sql_equal "select * from table1 where col1 like 'abc%' escape '@'",
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
                :condition => Ast::LikeCondition[
                  :target => Ast::Identifier[:name => 'col1'],
                  :like => Ast::Keyword[:name => 'like'],
                  :text => Ast::TextLiteral[:value => 'abc%'],
                  :escape => Ast::TextLiteral[:value => '@']
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_where_with_regexp_like_conditions_parseable
      assert_ast_sql_equal "select * from table1 where regexp_like(col1,'^Ste(v|ph)en$')",
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
                :condition => Ast::RegexpCondition[
                  :target => Ast::Identifier[:name => 'col1'],
                  :regexp => Ast::TextLiteral[:value => '^Ste(v|ph)en$']
                ]
              ]
            ]
          ]
        ]
    end
  end
end

