require File.expand_path('base_test.rb', File.dirname(__FILE__))
module Grammar
  class SelectJoinTest < BaseTest
    def test_join_clause_parseable
      assert_ast_sql_equal "select * from table1 inner join table2 on table1.col1 = table2.col1",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::Array[
                Ast::InnerJoinClause[
                  :table1 => Ast::TableReference[:table_name => Ast::Identifier[:name => "table1"]],
                  :inner => Ast::Keyword[:name => "inner"],
                  :join => Ast::Keyword[:name => "join"],
                  :table2 => Ast::TableReference[:table_name => Ast::Identifier[:name => "table2"]],
                  :on_or_using_clause => Ast::OnClause[
                    :on => Ast::Keyword[:name => 'on'],
                    :condition => OracleSqlParser::Ast::SimpleComparisonCondition[
                      :left => OracleSqlParser::Ast::Identifier[:name => "table1.col1"],
                      :op => "=",
                      :right => OracleSqlParser::Ast::Identifier[:name => "table2.col1"]
                    ]
                  ]
                ]
              ]
            ]
          ]
        ]
    end

    def test_inner_join_clause_with_on_parseable
      assert_ast_sql_equal "select * from table1 inner join table2 on table1.col1 = table2.col1",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::Array[
                Ast::InnerJoinClause[
                  :table1 => Ast::TableReference[:table_name => Ast::Identifier[:name => "table1"]],
                  :inner => Ast::Keyword[:name => "inner"],
                  :join => Ast::Keyword[:name => "join"],
                  :table2 => Ast::TableReference[:table_name => Ast::Identifier[:name => "table2"]],
                  :on_or_using_clause => Ast::OnClause[
                    :on => Ast::Keyword[:name => 'on'],
                    :condition => OracleSqlParser::Ast::SimpleComparisonCondition[
                      :left => OracleSqlParser::Ast::Identifier[:name => "table1.col1"],
                      :op => "=",
                      :right => OracleSqlParser::Ast::Identifier[:name => "table2.col1"]
                    ]
                  ]
                ]
              ]
            ]
          ]
        ]
    end

    def test_inner_join_clause_with_using_parseable
      assert_ast_sql_equal "select * from table1 inner join table2 using (col1,col2)",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::Array[
                  Ast::InnerJoinClause[
                  :table1 => Ast::TableReference[:table_name => Ast::Identifier[:name => "table1"]],
                  :inner => Ast::Keyword[:name => "inner"],
                  :join => Ast::Keyword[:name => "join"],
                  :table2 => Ast::TableReference[:table_name => Ast::Identifier[:name => "table2"]],
                  :on_or_using_clause => Ast::UsingClause[
                    :using => OracleSqlParser::Ast::Keyword[:name => 'using'],
                    :column_list => OracleSqlParser::Ast::Array[
                        OracleSqlParser::Ast::Identifier[:name => 'col1'],
                        OracleSqlParser::Ast::Identifier[:name => 'col2'],
                    ]
                  ]
                ]
              ]
            ]
          ]
        ]
    end

    def test_cross_join_clause_parseable
      assert_ast_sql_equal "select * from table1 cross join table2",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::Array[
                Ast::CrossNaturalJoinClause[
                  :table1 => Ast::TableReference[:table_name => Ast::Identifier[:name => "table1"]],
                  :cross => Ast::Keyword[:name => 'cross'],
                  :join => Ast::Keyword[:name => 'join'],
                  :table2 => Ast::TableReference[:table_name => Ast::Identifier[:name => "table2"]]
                ]
              ]
            ]
          ]
        ]
    end

    def test_cross_join_clause_with_natual_parseable
      assert_ast_sql_equal "select * from table1 natural join table2",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::Array[
                Ast::CrossNaturalJoinClause[
                  :table1 => Ast::TableReference[:table_name => Ast::Identifier[:name => "table1"]],
                  :natural => Ast::Keyword[:name => 'natural'],
                  :join => Ast::Keyword[:name => 'join'],
                  :table2 => Ast::TableReference[:table_name => Ast::Identifier[:name => "table2"]]
                ]
              ]
            ]
          ]
        ]
    end

    def test_cross_join_clause_with_natural_using_parseable
      assert_ast_sql_equal "select * from table1 natural inner join table2",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::Array[
                Ast::CrossNaturalJoinClause[
                  :table1 => Ast::TableReference[:table_name => Ast::Identifier[:name => "table1"]],
                  :natural => Ast::Keyword[:name => 'natural'],
                  :inner => Ast::Keyword[:name => 'inner'],
                  :join => Ast::Keyword[:name => 'join'],
                  :table2 => Ast::TableReference[:table_name => Ast::Identifier[:name => "table2"]]
                ]
              ]
            ]
          ]
        ]
    end

    def test_outer_join_clause_full_join_parseable
      assert_ast_sql_equal "select * from table1 full outer join table2 on table1.col1 = table2.col2",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::Array[
                Ast::OuterJoinClause[
                  :join_type => Ast::Keyword[:name => 'full'],
                  :outer => OracleSqlParser::Ast::Keyword[:name => "outer"],
                  :join => Ast::Keyword[:name => 'join'],
                  :table1 => Ast::TableReference[:table_name => Ast::Identifier[:name => "table1"]],
                  :on_or_using_clause => OracleSqlParser::Ast::OnClause[
                    :on => OracleSqlParser::Ast::Keyword[:name => "on"],
                    :condition => OracleSqlParser::Ast::SimpleComparisonCondition[
                      :left => OracleSqlParser::Ast::Identifier[:name => "table1.col1"],
                      :op => "=",
                      :right => OracleSqlParser::Ast::Identifier[:name => "table2.col2"]
                    ]
                  ],
                  :table2 => Ast::TableReference[:table_name => Ast::Identifier[:name => 'table2']],
                ]
              ]
            ]
          ]
        ]
    end

    def test_outer_join_clause_left_join_parseable
      assert_ast_sql_equal "select * from table1 left join table2 on table1.col1 = table2.col2",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::Array[
                Ast::OuterJoinClause[
                  :join_type => Ast::Keyword[:name => 'left'],
                  :join => Ast::Keyword[:name => 'join'],
                  :table1 => Ast::TableReference[:table_name => Ast::Identifier[:name => "table1"]],
                  :on_or_using_clause => OracleSqlParser::Ast::OnClause[
                    :on => OracleSqlParser::Ast::Keyword[:name => "on"],
                    :condition => OracleSqlParser::Ast::SimpleComparisonCondition[
                      :left => OracleSqlParser::Ast::Identifier[:name => "table1.col1"],
                      :op => "=",
                      :right => OracleSqlParser::Ast::Identifier[:name => "table2.col2"]
                    ]
                  ],
                  :table2 => Ast::TableReference[:table_name => Ast::Identifier[:name => 'table2']],
                ]
              ]
            ]
          ]
        ]
    end

    def test_outer_join_clause_right_join_parseable
      assert_ast_sql_equal "select * from table1 right join table2 on table1.col1 = table2.col2",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::Array[
                Ast::OuterJoinClause[
                  :join_type => Ast::Keyword[:name => 'right'],
                  :join => Ast::Keyword[:name => 'join'],
                  :table1 => Ast::TableReference[:table_name => Ast::Identifier[:name => "table1"]],
                  :on_or_using_clause => OracleSqlParser::Ast::OnClause[
                    :on => OracleSqlParser::Ast::Keyword[:name => "on"],
                    :condition => OracleSqlParser::Ast::SimpleComparisonCondition[
                      :left => OracleSqlParser::Ast::Identifier[:name => "table1.col1"],
                      :op => "=",
                      :right => OracleSqlParser::Ast::Identifier[:name => "table2.col2"]
                    ]
                  ],
                  :table2 => Ast::TableReference[:table_name => Ast::Identifier[:name => 'table2']],
                ]
              ]
            ]
          ]
        ]
    end

    def test_outer_join_clause_natural_join_parseable
      assert_ast_sql_equal "select * from table1 natural join table2 on table1.col1 = table2.col2",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::Array[
                Ast::OuterJoinClause[
                  :natural => Ast::Keyword[:name => 'natural'],
                  :join => Ast::Keyword[:name => 'join'],
                  :table1 => Ast::TableReference[:table_name => Ast::Identifier[:name => "table1"]],
                  :on_or_using_clause => OracleSqlParser::Ast::OnClause[
                    :on => OracleSqlParser::Ast::Keyword[:name => "on"],
                    :condition => OracleSqlParser::Ast::SimpleComparisonCondition[
                      :left => OracleSqlParser::Ast::Identifier[:name => "table1.col1"],
                      :op => "=",
                      :right => OracleSqlParser::Ast::Identifier[:name => "table2.col2"]
                    ]
                  ],
                  :table2 => Ast::TableReference[:table_name => Ast::Identifier[:name => 'table2']],
                ]
              ]
            ]
          ]
        ]
    end

    def test_outer_join_clause_natural_jointype_parseable
      assert_ast_sql_equal "select * from table1 natural left join table2 on table1.col1 = table2.col2",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::Array[
                Ast::OuterJoinClause[
                  :natural => Ast::Keyword[:name => 'natural'],
                  :join_type => Ast::Keyword[:name => 'left'],
                  :join => Ast::Keyword[:name => 'join'],
                  :table1 => Ast::TableReference[:table_name => Ast::Identifier[:name => "table1"]],
                  :on_or_using_clause => OracleSqlParser::Ast::OnClause[
                    :on => OracleSqlParser::Ast::Keyword[:name => "on"],
                    :condition => OracleSqlParser::Ast::SimpleComparisonCondition[
                      :left => OracleSqlParser::Ast::Identifier[:name => "table1.col1"],
                      :op => "=",
                      :right => OracleSqlParser::Ast::Identifier[:name => "table2.col2"]
                    ]
                  ],
                  :table2 => Ast::TableReference[:table_name => Ast::Identifier[:name => 'table2']],
                ]
              ]
            ]
          ]
        ]
    end

    def test_outer_join_clause_using_parseable
      assert_ast_sql_equal "select * from table1 natural left join table2 using (col1,col2)",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::Array[
                Ast::OuterJoinClause[
                  :natural => Ast::Keyword[:name => 'natural'],
                  :join_type => Ast::Keyword[:name => 'left'],
                  :join => Ast::Keyword[:name => 'join'],
                  :table1 => Ast::TableReference[:table_name => Ast::Identifier[:name => "table1"]],
                  :on_or_using_clause => Ast::UsingClause[
                    :using => OracleSqlParser::Ast::Keyword[:name => 'using'],
                    :column_list => OracleSqlParser::Ast::Array[
                        OracleSqlParser::Ast::Identifier[:name => 'col1'],
                        OracleSqlParser::Ast::Identifier[:name => 'col2'],
                    ]
                  ],
                  :table2 => Ast::TableReference[:table_name => Ast::Identifier[:name => 'table2']],
                ]
              ]
            ]
          ]
        ]
    end
  end
end
