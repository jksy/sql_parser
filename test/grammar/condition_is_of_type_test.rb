require File.expand_path('base_test.rb', File.dirname(__FILE__))

module Grammar
  class ConditionTest < BaseTest
    def test_select_where_is_of_type_condition_parseable
      assert_ast_sql_equal "select col1 from table1 where value(col1) is of type (type_t)",
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
                :condition => Ast::IsOfTypeCondition[
                  :target => Ast::FunctionExpression[
                    :name => Ast::Identifier[:name => 'value'],
                    :args => Ast::Array[
                      OracleSqlParser::Ast::Identifier[:name => 'col1']
                    ]
                  ],
                  :is => Ast::Keyword[:name => 'is'],
                  :of => Ast::Keyword[:name => 'of'],
                  :type => Ast::Keyword[:name => 'type'],
                  :types => Ast::Array[
                    Ast::OnlyAndType[
                      :type => Ast::Identifier[:name => 'type_t']
                    ]
                  ]
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_where_is_not_of_type_condition_parseable
      assert_ast_sql_equal "select col1 from table1 where value(col1) is not of type (type_t)",
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
                :condition => Ast::IsOfTypeCondition[
                  :target => Ast::FunctionExpression[
                    :name => Ast::Identifier[:name => 'value'],
                    :args => Ast::Array[
                      Ast::Identifier[:name => 'col1']
                    ]
                  ],
                  :is => Ast::Keyword[:name => 'is'],
                  :not => Ast::Keyword[:name => 'not'],
                  :of => Ast::Keyword[:name => 'of'],
                  :type => Ast::Keyword[:name => 'type'],
                  :types => Ast::Array[
                    Ast::OnlyAndType[
                      :type => Ast::Identifier[:name => 'type_t']
                    ]
                  ]
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_where_is_of_type_condition_no_type_parseable
      assert_ast_sql_equal "select col1 from table1 where value(col1) is not of (type_1)",
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
                :condition => Ast::IsOfTypeCondition[
                  :target => Ast::FunctionExpression[
                    :name => Ast::Identifier[:name => 'value'],
                    :args => Ast::Array[
                      Ast::Identifier[:name => 'col1']
                    ]
                  ],
                  :is => Ast::Keyword[:name => 'is'],
                  :not => Ast::Keyword[:name => 'not'],
                  :of => Ast::Keyword[:name => 'of'],
                  :types => Ast::Array[
                    Ast::OnlyAndType[
                      :type => Ast::Identifier[:name => 'type_1']
                    ]
                  ]
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_where_is_of_type_with_multiple_type_condition_parseable
      assert_ast_sql_equal "select col1 from table1 where value(col1) is not of type (type_1,only type_2)",
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
                :condition => Ast::IsOfTypeCondition[
                  :target => Ast::FunctionExpression[
                    :name => Ast::Identifier[:name => 'value'],
                    :args => Ast::Array[
                      Ast::Identifier[:name => 'col1']
                    ]
                  ],
                  :is => Ast::Keyword[:name => 'is'],
                  :not => Ast::Keyword[:name => 'not'],
                  :of => Ast::Keyword[:name => 'of'],
                  :type => Ast::Keyword[:name => 'type'],
                  :types => Ast::Array[
                    Ast::OnlyAndType[
                      :type => Ast::Identifier[:name => 'type_1']
                    ],
                    Ast::OnlyAndType[
                      :only => Ast::Keyword[:name => 'only'],
                      :type => Ast::Identifier[:name => 'type_2']
                    ]
                  ]
                ]
              ]
            ]
          ]
        ]
    end
  end
end
