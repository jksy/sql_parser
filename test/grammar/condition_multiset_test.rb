require File.expand_path('base_test.rb', File.dirname(__FILE__))

module Grammar
  class ConditionMultisetTest < BaseTest
    def test_select_where_is_a_set_condition_parseable
      assert_ast_sql_equal "select col1 from table1 where col1 is a set",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => Ast::Identifier[:name => 'col1']
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name => Ast::Identifier[:name => 'table1']
                ]
              ],
              :where_clause => Ast::WhereClause[
                :condition => Ast::IsASetCondition[
                  :target => Ast::Identifier[:name => 'col1'],
                  :is => Ast::Keyword[:name => 'is'],
                  :a => Ast::Keyword[:name => 'a'],
                  :set => Ast::Keyword[:name => 'set'],
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_where_is_not_a_set_condition_parseable
      assert_ast_sql_equal "select col1 from table1 where col1 is not a set",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => Ast::Identifier[:name => 'col1']
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name => Ast::Identifier[:name => 'table1']
                ]
              ],
              :where_clause => Ast::WhereClause[
                :condition => Ast::IsASetCondition[
                  :target => Ast::Identifier[:name => 'col1'],
                  :is => Ast::Keyword[:name => 'is'],
                  :not => Ast::Keyword[:name => 'not'],
                  :a => Ast::Keyword[:name => 'a'],
                  :set => Ast::Keyword[:name => 'set'],
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_where_is_empty_condition_parseable
      assert_ast_sql_equal "select col1 from table1 where col1 is empty",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => Ast::Identifier[:name => 'col1']
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name => Ast::Identifier[:name => 'table1']
                ]
              ],
              :where_clause => Ast::WhereClause[
                :condition => Ast::IsEmptyCondition[
                  :target => Ast::Identifier[:name => 'col1'],
                  :is => Ast::Keyword[:name => 'is'],
                  :empty => Ast::Keyword[:name => 'empty'],
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_where_is_not_empty_condition_parseable
      assert_ast_sql_equal "select col1 from table1 where col1 is not empty",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => Ast::Identifier[:name => 'col1']
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name => Ast::Identifier[:name => 'table1']
                ]
              ],
              :where_clause => Ast::WhereClause[
                :condition => Ast::IsEmptyCondition[
                  :target => Ast::Identifier[:name => 'col1'],
                  :is => Ast::Keyword[:name => 'is'],
                  :not => Ast::Keyword[:name => 'not'],
                  :empty => Ast::Keyword[:name => 'empty'],
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_where_member_condition_parseable
      assert_ast_sql_equal "select col1 from table1 where col1 member of col2",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => Ast::Identifier[:name => 'col1']
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name => Ast::Identifier[:name => 'table1']
                ]
              ],
              :where_clause => Ast::WhereClause[
                :condition => Ast::MemberCondition[
                  :target => Ast::Identifier[:name => 'col1'],
                  :member => Ast::Keyword[:name => 'member'],
                  :of => Ast::Keyword[:name => 'of'],
                  :table => Ast::Identifier[:name => 'col2']
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_where_not_member_condition_parseable
      assert_ast_sql_equal "select col1 from table1 where col1 not member of col2",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => Ast::Identifier[:name => 'col1']
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name => Ast::Identifier[:name => 'table1']
                ]
              ],
              :where_clause => Ast::WhereClause[
                :condition => Ast::MemberCondition[
                  :target => Ast::Identifier[:name => 'col1'],
                  :member => Ast::Keyword[:name => 'member'],
                  :not => Ast::Keyword[:name => 'not'],
                  :of => Ast::Keyword[:name => 'of'],
                  :table => Ast::Identifier[:name => 'col2']
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_where_submultiset_condition_parseable
      assert_ast_sql_equal "select col1 from table1 where col1 submultiset col2",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => Ast::Identifier[:name => 'col1']
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name => Ast::Identifier[:name => 'table1']
                ]
              ],
              :where_clause => Ast::WhereClause[
                :condition => Ast::SubmultisetCondition[
                  :target => Ast::Identifier[:name => 'col1'],
                  :submultiset => Ast::Keyword[:name => 'submultiset'],
                  :table => Ast::Identifier[:name => 'col2']
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_where_submultiset_of_condition_parseable
      assert_ast_sql_equal "select col1 from table1 where col1 submultiset of col2",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => Ast::Identifier[:name => 'col1']
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name => Ast::Identifier[:name => 'table1']
                ]
              ],
              :where_clause => Ast::WhereClause[
                :condition => Ast::SubmultisetCondition[
                  :target => Ast::Identifier[:name => 'col1'],
                  :submultiset => Ast::Keyword[:name => 'submultiset'],
                  :of => Ast::Keyword[:name => 'of'],
                  :table => Ast::Identifier[:name => 'col2']
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_where_not_submultiset_condition_parseable
      assert_ast_sql_equal "select col1 from table1 where col1 not submultiset col2",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => Ast::Identifier[:name => 'col1']
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name => Ast::Identifier[:name => 'table1']
                ]
              ],
              :where_clause => Ast::WhereClause[
                :condition => Ast::SubmultisetCondition[
                  :target => Ast::Identifier[:name => 'col1'],
                  :not => Ast::Keyword[:name => 'not'],
                  :submultiset => Ast::Keyword[:name => 'submultiset'],
                  :table => Ast::Identifier[:name => 'col2']
                ]
              ]
            ]
          ]
        ]
    end
  end
end
