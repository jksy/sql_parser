require File.expand_path('base_test.rb', File.dirname(__FILE__))

module Grammar
  class ConditionLogicalTest < BaseTest
    def test_select_where_with_logical_and_conditions_parseable
      assert_ast_sql_equal "select * from table1 where col1 = col2 and col3 = col4",
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
                :condition => Ast::LogicalCondition[
                  :left => Ast::SimpleComparisonCondition[
                    :left => Ast::Identifier[:name => 'col1'],
                    :op => '=',
                    :right => Ast::Identifier[:name => 'col2']
                  ],
                  :op => Ast::Keyword[:name => 'and'],
                  :right => Ast::SimpleComparisonCondition[
                    :left => Ast::Identifier[:name => 'col3'],
                    :op => '=',
                    :right => Ast::Identifier[:name => 'col4']
                  ]
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_where_with_plural_2_and_conditions_parseable
      assert_ast_sql_equal "select * from table1 where col1 = col2 and col3 = col4 and col5 = col6",
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
                :condition => Ast::LogicalCondition[
                  :left => Ast::SimpleComparisonCondition[
                    :left => Ast::Identifier[:name => 'col1'],
                    :op => '=',
                    :right => Ast::Identifier[:name => 'col2']
                  ],
                  :op => Ast::Keyword[:name => 'and'],
                  :right => Ast::LogicalCondition[
                    :left => Ast::SimpleComparisonCondition[
                      :left => Ast::Identifier[:name => 'col3'],
                      :op => '=',
                      :right => Ast::Identifier[:name => 'col4']
                    ],
                    :op => Ast::Keyword[:name => 'and'],
                    :right => Ast::SimpleComparisonCondition[
                      :left => Ast::Identifier[:name => 'col5'],
                      :op => '=',
                      :right => Ast::Identifier[:name => 'col6']
                    ],
                  ]
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_where_with_plural_3_and_conditions_parseable
      assert_ast_sql_equal "select * from table1 where col1 = col2 and col3 = col4 and col5 = col6 and col7 = col8",
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
                :condition => Ast::LogicalCondition[
                  :left => Ast::SimpleComparisonCondition[
                    :left => Ast::Identifier[:name => 'col1'],
                    :op => '=',
                    :right => Ast::Identifier[:name => 'col2']
                  ],
                  :op => Ast::Keyword[:name => 'and'],
                  :right => Ast::LogicalCondition[
                    :left => Ast::SimpleComparisonCondition[
                      :left => Ast::Identifier[:name => 'col3'],
                      :op => '=',
                      :right => Ast::Identifier[:name => 'col4']
                    ],
                    :op => Ast::Keyword[:name => 'and'],
                    :right => Ast::LogicalCondition[
                      :left => Ast::SimpleComparisonCondition[
                        :left => Ast::Identifier[:name => 'col5'],
                        :op => '=',
                        :right => Ast::Identifier[:name => 'col6']
                      ],
                      :op => Ast::Keyword[:name => 'and'],
                      :right => Ast::SimpleComparisonCondition[
                        :left => Ast::Identifier[:name => 'col7'],
                        :op => '=',
                        :right => Ast::Identifier[:name => 'col8']
                      ],
                    ]
                  ]
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_where_with_logical_or_conditions_parseable
      assert_ast_sql_equal "select * from table1 where col1 = col2 or col3 = col4",
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
                :condition => Ast::LogicalCondition[
                  :left => Ast::SimpleComparisonCondition[
                    :left => Ast::Identifier[:name => 'col1'],
                    :op => '=',
                    :right => Ast::Identifier[:name => 'col2']
                  ],
                  :op => Ast::Keyword[:name => 'or'],
                  :right => Ast::SimpleComparisonCondition[
                    :left => Ast::Identifier[:name => 'col3'],
                    :op => '=',
                    :right => Ast::Identifier[:name => 'col4']
                  ]
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_where_with_logical_2_or_conditions_parseable
      assert_ast_sql_equal "select * from table1 where col1 = col2 or col3 = col4 or col5 = col6",
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
                :condition => Ast::LogicalCondition[
                  :left => Ast::SimpleComparisonCondition[
                    :left => Ast::Identifier[:name => 'col1'],
                    :op => '=',
                    :right => Ast::Identifier[:name => 'col2']
                  ],
                  :op => Ast::Keyword[:name => 'or'],
                  :right => Ast::LogicalCondition[
                    :left => Ast::SimpleComparisonCondition[
                      :left => Ast::Identifier[:name => 'col3'],
                      :op => '=',
                      :right => Ast::Identifier[:name => 'col4']
                    ],
                    :op => Ast::Keyword[:name => 'or'],
                    :right => Ast::SimpleComparisonCondition[
                      :left => Ast::Identifier[:name => 'col5'],
                      :op => '=',
                      :right => Ast::Identifier[:name => 'col6']
                    ]
                  ]
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_where_with_logical_3_or_conditions_parseable
      assert_ast_sql_equal "select * from table1 where col1 = col2 or col3 = col4 or col5 = col6 or col7 = col8",
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
                :condition => Ast::LogicalCondition[
                  :left => Ast::SimpleComparisonCondition[
                    :left => Ast::Identifier[:name => 'col1'],
                    :op => '=',
                    :right => Ast::Identifier[:name => 'col2']
                  ],
                  :op => Ast::Keyword[:name => 'or'],
                  :right => Ast::LogicalCondition[
                    :left => Ast::SimpleComparisonCondition[
                      :left => Ast::Identifier[:name => 'col3'],
                      :op => '=',
                      :right => Ast::Identifier[:name => 'col4']
                    ],
                    :op => Ast::Keyword[:name => 'or'],
                    :right => Ast::LogicalCondition[
                      :left => Ast::SimpleComparisonCondition[
                        :left => Ast::Identifier[:name => 'col5'],
                        :op => '=',
                        :right => Ast::Identifier[:name => 'col6']
                      ],
                      :op => Ast::Keyword[:name => 'or'],
                      :right => Ast::SimpleComparisonCondition[
                        :left => Ast::Identifier[:name => 'col7'],
                        :op => '=',
                        :right => Ast::Identifier[:name => 'col8']
                      ]
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
