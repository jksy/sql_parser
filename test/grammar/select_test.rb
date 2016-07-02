require File.expand_path('base_test.rb', File.dirname(__FILE__))

module Grammar
  class SelectTest < BaseTest
    def test_select_parseable
      assert_ast_sql_equal(
        "select col1 from table1",
         Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => 'col1']
              ],
              :select_sources => Ast::TableReference[:table_name => Ast::Identifier[:name => 'table1']]
            ],
          ],
        ]
      )
    end

    def test_select_multiple_column_parseable
      assert_ast_sql_equal(
        "select col1,col2,col3 from table1",
         Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => 'col1'],
                Ast::Identifier[:name => 'col2'],
                Ast::Identifier[:name => 'col3']
              ],
              :select_sources => Ast::TableReference[:table_name => Ast::Identifier[:name => 'table1']]
            ],
          ],
        ]
      )
    end

    def test_identifier_is_wrapperd_double_quote
      assert_ast_sql_equal(
        'select col1 from "table1"',
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => 'col1']
              ],
              :select_sources => Ast::TableReference[:table_name => Ast::Identifier[:name => 'table1', :quoted => true]]
            ],
          ],
        ]
      )
    end

    def test_select_all_parseable
      assert_ast_sql_equal(
        'select all col1 from table1',
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :modifier => Ast::Keyword[:name => 'all'],
              :select_list => Ast::Array[
                Ast::Identifier[:name => 'col1']
              ],
              :select_sources => Ast::TableReference[:table_name => Ast::Identifier[:name => 'table1']]
            ]
          ]
        ]
      )
    end

    def test_select_distinct_parseable
      assert_ast_sql_equal(
        'select distinct col2 from table1',
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :modifier => Ast::Keyword[:name => 'distinct'],
              :select_list => Ast::Array[
                Ast::Identifier[:name => 'col2']
              ],
              :select_sources => Ast::TableReference[:table_name => Ast::Identifier[:name => 'table1']]
            ]
          ]
        ]
      )
    end

    def test_select_unique_parseable
      assert_ast_sql_equal(
        'select unique col2 from table1',
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :modifier => Ast::Keyword[:name => 'unique'],
              :select_list => Ast::Array[
                Ast::Identifier[:name => 'col2']
              ],
              :select_sources => Ast::TableReference[:table_name => Ast::Identifier[:name => 'table1']]
            ]
          ]
        ]
      )
    end

    def test_select_union_parseable
      assert_ast_sql_equal 'select col1 from table1 union select col2 from table2',
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block1 => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => 'col1']
              ],
              :select_sources => Ast::TableReference[:table_name => Ast::Identifier[:name => 'table1']]
            ],
            :union => Ast::Array[
              Ast::Keyword[:name => 'union']
            ],
            :query_block2 => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => 'col2']
              ],
              :select_sources => Ast::TableReference[:table_name => Ast::Identifier[:name => 'table2']]
            ],
          ]
        ]
    end

    def test_select_union_all_parseable
      assert_ast_sql_equal 'select col1 from table1 union all select col2 from table2',
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block1 => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => 'col1']
              ],
              :select_sources => Ast::TableReference[:table_name => Ast::Identifier[:name => 'table1']]
            ],
            :union => Ast::Array[
              Ast::Keyword[:name => 'union'],
              Ast::Keyword[:name => 'all']
            ],
            :query_block2 => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => 'col2']
              ],
              :select_sources => Ast::TableReference[:table_name => Ast::Identifier[:name => 'table2']]
            ],
          ]
        ]
    end

    def test_select_intersect_parseable
      assert_ast_sql_equal 'select col1 from table1 intersect select col2 from table2',
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block1 => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => 'col1']
              ],
              :select_sources => Ast::TableReference[:table_name => Ast::Identifier[:name => 'table1']]
            ],
            :union => Ast::Array[
              Ast::Keyword[:name => 'intersect']
            ],
            :query_block2 => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => 'col2']
              ],
              :select_sources => Ast::TableReference[:table_name => Ast::Identifier[:name => 'table2']]
            ],
          ]
        ]
    end

    def test_select_minus_parseable
      assert_ast_sql_equal 'select col1 from table1 minus select col2 from table2',
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block1 => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => 'col1']
              ],
              :select_sources => Ast::TableReference[:table_name => Ast::Identifier[:name => 'table1']]
            ],
            :union => Ast::Array[
              Ast::Keyword[:name => 'minus']
            ],
            :query_block2 => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => 'col2']
              ],
              :select_sources => Ast::TableReference[:table_name => Ast::Identifier[:name => 'table2']]
            ],
          ]
        ]
    end

    def test_select_literal_number_column_parseable
      assert_ast_sql_equal(
        'select 1 from table1',
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::NumberLiteral[:value => '1']
              ],
              :select_sources => Ast::TableReference[:table_name => Ast::Identifier[:name => 'table1']]
            ]
          ]
        ]
      )
    end

    def test_select_literal_nagative_number_column_parseable
      assert_ast_sql_equal(
        'select -1 from table1',
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::NumberLiteral[:value => '-1']
              ],
              :select_sources => Ast::TableReference[:table_name => Ast::Identifier[:name => 'table1']]
            ]
          ]
        ]
      )
    end

    def test_select_literal_float_number_column_parseable
      assert_ast_sql_equal(
        'select 1.1 from table1',
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::NumberLiteral[:value => '1.1']
              ],
              :select_sources => Ast::TableReference[:table_name => Ast::Identifier[:name => 'table1']]
            ]
          ]
        ]
      )
    end

    def test_select_literal_float_nagavite_number_column_parseable
      assert_ast_sql_equal(
        'select -1.1 from table1',
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::NumberLiteral[:value => '-1.1']
              ],
              :select_sources => Ast::TableReference[:table_name => Ast::Identifier[:name => 'table1']]
            ]
          ]
        ]
      )
    end

    def test_select_literal_string_parseable
      assert_ast_sql_equal(
        "select 'adslfael' from table1" ,
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::TextLiteral[:value => 'adslfael']
              ],
              :select_sources => Ast::TableReference[:table_name => Ast::Identifier[:name => 'table1']]
            ]
          ]
        ]
      )
    end

    def test_select_asterisk_parseable
      assert_ast_sql_equal(
        "select * from table1",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::TableReference[:table_name => Ast::Identifier[:name => 'table1']]
            ]
          ]
        ]
      )
    end

    def test_select_column_alias_parseable
      assert_ast_sql_equal(
        "select a as b from table1",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[
                  :name => 'a',
                  :as => Ast::Keyword[:name => "as"],
                  :alias => Ast::Identifier[:name => "b"]
                ]
              ],
              :select_sources => Ast::TableReference[:table_name => Ast::Identifier[:name => 'table1']]
            ]
          ]
        ]
      )
    end

    def test_select_table_and_asterisk_parseable
      assert_ast_sql_equal(
        "select table1.* from table1",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => 'table1.*']
              ],
              :select_sources => Ast::TableReference[:table_name => Ast::Identifier[:name => 'table1']]
            ]
          ]
        ]
      )
    end

    def test_join_clause_parseable
      assert_ast_sql_equal "select * from table1 inner join table2 on table1.col1 = table2.col1",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::InnerJoinClause[
                :table1 => Ast::TableReference[:table_name => Ast::Identifier[:name => "table1"]],
                :inner => Ast::Keyword[:name => "inner"],
                :join => Ast::Keyword[:name => "join"],
                :table2 => Ast::TableReference[:table_name => Ast::Identifier[:name => "table2"]],
                :on_or_using_clause => Ast::OnClause[
                  :on => Ast::Keyword[:name => 'on'],
                  :condition => OracleSqlParser::Ast::SimpleComparisionCondition[
                    :left => OracleSqlParser::Ast::Identifier[:name => "table1.col1"],
                    :op => "=",
                    :right => OracleSqlParser::Ast::Identifier[:name => "table2.col1"]
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
              :select_sources => Ast::InnerJoinClause[
                :table1 => Ast::TableReference[:table_name => Ast::Identifier[:name => "table1"]],
                :inner => Ast::Keyword[:name => "inner"],
                :join => Ast::Keyword[:name => "join"],
                :table2 => Ast::TableReference[:table_name => Ast::Identifier[:name => "table2"]],
                :on_or_using_clause => Ast::OnClause[
                  :on => Ast::Keyword[:name => 'on'],
                  :condition => OracleSqlParser::Ast::SimpleComparisionCondition[
                    :left => OracleSqlParser::Ast::Identifier[:name => "table1.col1"],
                    :op => "=",
                    :right => OracleSqlParser::Ast::Identifier[:name => "table2.col1"]
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
              :select_sources => Ast::InnerJoinClause[
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
    end

    def test_cross_join_clause_parseable
      assert_ast_sql_equal "select * from table1 cross join table2",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::CrossNaturalJoinClause[
                :table1 => Ast::TableReference[:table_name => Ast::Identifier[:name => "table1"]],
                :cross => Ast::Keyword[:name => 'cross'],
                :join => Ast::Keyword[:name => 'join'],
                :table2 => Ast::TableReference[:table_name => Ast::Identifier[:name => "table2"]]
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
              :select_sources => Ast::CrossNaturalJoinClause[
                :table1 => Ast::TableReference[:table_name => Ast::Identifier[:name => "table1"]],
                :natural => Ast::Keyword[:name => 'natural'],
                :join => Ast::Keyword[:name => 'join'],
                :table2 => Ast::TableReference[:table_name => Ast::Identifier[:name => "table2"]]
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
              :select_sources => Ast::CrossNaturalJoinClause[
                :table1 => Ast::TableReference[:table_name => Ast::Identifier[:name => "table1"]],
                :natural => Ast::Keyword[:name => 'natural'],
                :inner => Ast::Keyword[:name => 'inner'],
                :join => Ast::Keyword[:name => 'join'],
                :table2 => Ast::TableReference[:table_name => Ast::Identifier[:name => "table2"]]
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
              :select_sources => Ast::OuterJoinClause[
                :join_type => Ast::Keyword[:name => 'full'],
                :outer => OracleSqlParser::Ast::Keyword[:name => "outer"],
                :join => Ast::Keyword[:name => 'join'],
                :table1 => Ast::TableReference[:table_name => Ast::Identifier[:name => "table1"]],
                :on_or_using_clause => OracleSqlParser::Ast::OnClause[
                  :on => OracleSqlParser::Ast::Keyword[:name => "on"],
                  :condition => OracleSqlParser::Ast::SimpleComparisionCondition[
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
    end

    def test_outer_join_clause_left_join_parseable
      assert_ast_sql_equal "select * from table1 left join table2 on table1.col1 = table2.col2",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::OuterJoinClause[
                :join_type => Ast::Keyword[:name => 'left'],
                :join => Ast::Keyword[:name => 'join'],
                :table1 => Ast::TableReference[:table_name => Ast::Identifier[:name => "table1"]],
                :on_or_using_clause => OracleSqlParser::Ast::OnClause[
                  :on => OracleSqlParser::Ast::Keyword[:name => "on"],
                  :condition => OracleSqlParser::Ast::SimpleComparisionCondition[
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
    end

    def test_outer_join_clause_right_join_parseable
      assert_ast_sql_equal "select * from table1 right join table2 on table1.col1 = table2.col2",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::OuterJoinClause[
                :join_type => Ast::Keyword[:name => 'right'],
                :join => Ast::Keyword[:name => 'join'],
                :table1 => Ast::TableReference[:table_name => Ast::Identifier[:name => "table1"]],
                :on_or_using_clause => OracleSqlParser::Ast::OnClause[
                  :on => OracleSqlParser::Ast::Keyword[:name => "on"],
                  :condition => OracleSqlParser::Ast::SimpleComparisionCondition[
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
    end

    def test_outer_join_clause_natural_join_parseable
      assert_ast_sql_equal "select * from table1 natural join table2 on table1.col1 = table2.col2",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::OuterJoinClause[
                :natural => Ast::Keyword[:name => 'natural'],
                :join => Ast::Keyword[:name => 'join'],
                :table1 => Ast::TableReference[:table_name => Ast::Identifier[:name => "table1"]],
                :on_or_using_clause => OracleSqlParser::Ast::OnClause[
                  :on => OracleSqlParser::Ast::Keyword[:name => "on"],
                  :condition => OracleSqlParser::Ast::SimpleComparisionCondition[
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
    end

    def test_outer_join_clause_natural_jointype_parseable
      assert_ast_sql_equal "select * from table1 natural left join table2 on table1.col1 = table2.col2",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::OuterJoinClause[
                :natural => Ast::Keyword[:name => 'natural'],
                :join_type => Ast::Keyword[:name => 'left'],
                :join => Ast::Keyword[:name => 'join'],
                :table1 => Ast::TableReference[:table_name => Ast::Identifier[:name => "table1"]],
                :on_or_using_clause => OracleSqlParser::Ast::OnClause[
                  :on => OracleSqlParser::Ast::Keyword[:name => "on"],
                  :condition => OracleSqlParser::Ast::SimpleComparisionCondition[
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
    end

    def test_outer_join_clause_using_parseable
      assert_ast_sql_equal "select * from table1 natural left join table2 using (col1,col2)",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::OuterJoinClause[
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

    end

    def test_select_where_parseable
      assert_ast_sql_equal(
        "select * from table1 where col1 = col1",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::TableReference[:table_name => Ast::Identifier[:name => 'table1']],
              :where_clause => Ast::WhereClause[
                :condition => Ast::SimpleComparisionCondition[
                  :left => Ast::Identifier[:name => 'col1'],
                  :op => '=',
                  :right => Ast::Identifier[:name => 'col1']
                ]
              ]
            ]
          ]
        ]
      )
    end

    def test_select_group_by_expr_parseable
      assert_ast_sql_equal(
        "select * from table1 group by col1,col2",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::TableReference[:table_name => Ast::Identifier[:name => 'table1']],
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
              :select_sources => Ast::TableReference[:table_name => Ast::Identifier[:name => 'table1']],
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

    def test_select_rollup_clause_parseable
      assert_ast_sql_equal "select * from table1 group by rollup(col1,col2)",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::TableReference[:table_name => Ast::Identifier[:name => 'table1']],
              :group_by_clause => Ast::GroupByClause[
                :targets => Ast::Array[
                  Ast::RollupCubeClause[
                    :func_name => Ast::Keyword[:name => 'rollup'],
                    :args => Ast::Array[
                      Ast::Identifier[:name => 'col1'],
                      Ast::Identifier[:name => 'col2']
                    ]
                  ],
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_cube_clause_parseable
      assert_ast_sql_equal "select * from table1 group by cube(col1,col2)",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::TableReference[:table_name => Ast::Identifier[:name => 'table1']],
              :group_by_clause => Ast::GroupByClause[
                :targets => Ast::Array[
                  Ast::RollupCubeClause[
                    :func_name => Ast::Keyword[:name => 'cube'],
                    :args => Ast::Array[
                      Ast::Identifier[:name => 'col1'],
                      Ast::Identifier[:name => 'col2']
                    ]
                  ],
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_for_update_clause_parseable
      assert_ast_sql_equal "select * from table1 for update",
        Ast::SelectStatement[
          :subquery => generate_ast("select * from table1").subquery,
          :for_update_clause => Ast::ForUpdateClause[{}]
        ]
    end

    def test_select_for_update_clause_column_parseable
      assert_ast_sql_equal "select * from table1 for update of column1",
        Ast::SelectStatement[
          :subquery => generate_ast("select * from table1").subquery,
          :for_update_clause => Ast::ForUpdateClause[
            :columns => Ast::Array[
              Ast::Identifier[:name => 'column1']
            ]
          ]
        ]
    end

    def test_select_for_update_clause_table_and_column_parseable
      assert_ast_sql_equal "select * from table1 for update of table1.column1",
        Ast::SelectStatement[
          :subquery => generate_ast("select * from table1").subquery,
          :for_update_clause => Ast::ForUpdateClause[
            :columns => Ast::Array[
              Ast::Identifier[:name => 'table1.column1']
            ]
          ]
        ]
    end

    def test_select_for_update_clause_schema_and_table_and_column_parseable
      assert_ast_sql_equal "select * from table1 for update of schema1.table1.column1",
        Ast::SelectStatement[
          :subquery => generate_ast("select * from table1").subquery,
          :for_update_clause => Ast::ForUpdateClause[
            :columns => Ast::Array[
              Ast::Identifier[:name => 'schema1.table1.column1']
            ]
          ]
        ]
    end

    def test_select_for_update_clause_nowait_parseable
      assert_ast_sql_equal "select * from table1 for update nowait",
        Ast::SelectStatement[
          :subquery => generate_ast("select * from table1").subquery,
          :for_update_clause => Ast::ForUpdateClause[
            :wait => Ast::Keyword[:name => 'nowait']
          ]
        ]
    end

    def test_select_for_update_clause_wait_parseable
      assert_ast_sql_equal "select * from table1 for update wait 1",
        Ast::SelectStatement[
          :subquery => generate_ast("select * from table1").subquery,
          :for_update_clause => Ast::ForUpdateClause[
            :wait => Ast::Keyword[:name => 'wait'],
            :time => Ast::NumberLiteral[:value => '1']
          ]
        ]
    end

    def test_select_order_by_clause_expr_parseable
      assert_ast_sql_equal "select * from table1 order by col1",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => generate_ast("select * from table1").subquery.query_block,
            :order_by_clause => Ast::OrderByClause[
              :items => Ast::Array[
                Ast::OrderByClauseItem[
                  :target => Ast::Identifier[:name => 'col1']
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_order_by_clause_position_parseable
      assert_ast_sql_equal "select * from table1 order by 1",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => generate_ast("select * from table1").subquery.query_block,
            :order_by_clause => Ast::OrderByClause[
              :items => Ast::Array[
                Ast::OrderByClauseItem[
                  :target => Ast::NumberLiteral[:value => '1']
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_order_by_clause_siblings_parseable
      assert_ast_sql_equal "select * from table1 order siblings by 1",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => generate_ast("select * from table1").subquery.query_block,
            :order_by_clause => Ast::OrderByClause[
              :siblings => Ast::Keyword[:name => 'siblings'],
              :items => Ast::Array[
                Ast::OrderByClauseItem[
                  :target => Ast::NumberLiteral[:value => '1']
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_order_by_clause_asc_parseable
      assert_ast_sql_equal "select * from table1 order by col1 asc",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => generate_ast("select * from table1").subquery.query_block,
            :order_by_clause => Ast::OrderByClause[
              :items => Ast::Array[
                Ast::OrderByClauseItem[
                  :target => Ast::Identifier[:name => 'col1'],
                  :asc => Ast::Keyword[:name => 'asc']
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_order_by_clause_desc_parseable
      assert_ast_sql_equal "select * from table1 order by col1 desc",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => generate_ast("select * from table1").subquery.query_block,
            :order_by_clause => Ast::OrderByClause[
              :items => Ast::Array[
                Ast::OrderByClauseItem[
                  :target => Ast::Identifier[:name => 'col1'],
                  :asc => Ast::Keyword[:name => 'desc']
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_order_by_clause_nulls_first_parseable
      assert_ast_sql_equal "select * from table1 order by col1 nulls first",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => generate_ast("select * from table1").subquery.query_block,
            :order_by_clause => Ast::OrderByClause[
              :items => Ast::Array[
                Ast::OrderByClauseItem[
                  :target => Ast::Identifier[:name => 'col1'],
                  :nulls => Ast::Keyword[:name => 'first']
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_order_by_clause_nulls_last_parseable
      assert_ast_sql_equal "select * from table1 order by col1 nulls last",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => generate_ast("select * from table1").subquery.query_block,
            :order_by_clause => Ast::OrderByClause[
              :items => Ast::Array[
                Ast::OrderByClauseItem[
                  :target => Ast::Identifier[:name => 'col1'],
                  :nulls => Ast::Keyword[:name => 'last']
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_order_by_clause_plural_column_parseable
      assert_ast_sql_equal "select * from table1 order by col1 asc,col2 desc",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => generate_ast("select * from table1").subquery.query_block,
            :order_by_clause => Ast::OrderByClause[
              :items => Ast::Array[
                Ast::OrderByClauseItem[
                  :target => Ast::Identifier[:name => 'col1'],
                  :asc => Ast::Keyword[:name => 'asc']
                ],
                Ast::OrderByClauseItem[
                  :target => Ast::Identifier[:name => 'col2'],
                  :asc => Ast::Keyword[:name => 'desc']
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_table_alias
      assert_ast_sql_equal "select a.* from table1 a",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => 'a.*']
              ],
              :select_sources => OracleSqlParser::Ast::TableReference[
                :table_name => OracleSqlParser::Ast::Identifier[:name => 'table1'],
                :table_alias => OracleSqlParser::Ast::Identifier[:name => 'a'],
              ]
            ]
          ]
        ]
    end

  end
end
