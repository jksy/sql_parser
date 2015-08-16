require File.expand_path('base_test.rb', File.dirname(__FILE__))

module Grammar
  class SelectTest < BaseTest
    def test_select_parseable
      assert_ast_sql_eual(
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

    def test_identifier_is_wrapperd_double_quote
      assert_ast_sql_eual(
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
      assert_ast_sql_eual(
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
      assert_ast_sql_eual(
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
      same_ast? 'select unique col2 from table1',
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
    end
  
    def test_select_union_parseable
      # do not support union ast
      parse_successful 'select col1 from table1 union select col1 from table2'
    end
  
    def test_select_union_all_parseable
      # do not support union ast
      parse_successful 'select col1 from table1 union all select col1 from table2'
    end
  
    def test_select_intersect_parseable
     # do not support intersect ast
      parse_successful 'select col1 from table1 intersect select col1 from table2'
    end
  
    def test_select_minus_parseable
     # do not support minus ast
      parse_successful 'select col1 from table1 minus select col1 from table2'
    end
  
    def test_select_literal_number_column_parseable
      same_ast? 'select 1 from table1',
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
    end
  
    def test_select_literal_nagative_number_column_parseable
      same_ast? 'select -1 from table1',
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
    end
  
    def test_select_literal_float_number_column_parseable
      same_ast? 'select 1.1 from table1',
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
    end
  
    def test_select_literal_float_nagavite_number_column_parseable
      same_ast? 'select -1.1 from table1',
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
    end
  
    def test_select_literal_string_parseable
      same_ast? "select 'adslfael' from table1" ,
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
    end
  
    def test_select_asterisk_parseable
      same_ast? "select * from table1",
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
    end
  
    def test_select_table_and_asterisk_parseable
      same_ast? "select table1.* from table1",
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
    end
  
    def test_join_clause_parseable
      # do not support join clause ast
      parse_successful "select * from table1 inner join table2 on table1.col1 = table2.col1"
    end
  
    def test_inner_join_clause_with_on_parseable
      # do not support join clause ast
      parse_successful "select * from table1 inner join table2 on table1.col1 = table2.col1"
    end
  
    def test_inner_join_clause_with_using_parseable
      # do not support join clause ast
      parse_successful "select * from table1 inner join table2 using (col1, col2)"
    end
  
    def test_cross_join_clause_parseable
      # do not support join clause ast
      parse_successful "select * from table1 cross join table2"
    end
  
    def test_cross_join_clause_with_natual_parseable
      # do not support join clause ast
      parse_successful "select * from table1 natural join table2"
    end
  
    def test_cross_join_clause_with_natural_using_parseable
      # do not support join clause ast
      parse_successful "select * from table1 natural inner join table2"
    end
  
    def test_outer_join_clause_full_join_parseable
      # do not support join clause ast
      parse_successful "select * from table1 full outer join table2 on table1.col1 = table2.col2"
    end
  
    def test_outer_join_clause_left_join_parseable
      # do not support join clause ast
      parse_successful "select * from table1 left join table2 on table1.col1 = table2.col2"
    end
  
    def test_outer_join_clause_right_join_parseable
      # do not support join clause ast
      parse_successful "select * from table1 right join table2 on table1.col1 = table2.col2"
    end
  
    def test_outer_join_clause_natural_join_parseable
      # do not support join clause ast
      parse_successful "select * from table1 natural join table2 on table1.col1 = table2.col2"
    end
  
    def test_outer_join_clause_natural_jointype_parseable
      # do not support join clause ast
      parse_successful "select * from table1 natural left join table2 on table1.col1 = table2.col2"
    end
  
    def test_outer_join_clause_using_parseable
      # do not support join clause ast
      parse_successful "select * from table1 natural left join table2 using (col1, col2)"
    end
  
    def test_select_where_parseable
      same_ast? "select * from table1 where col1 = col1",
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
    end
  
    def test_select_group_by_expr_parseable
      same_ast? "select * from table1 group by col1, col2",
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
    end
  
    def test_select_group_by_having_condition_parseable
      same_ast? "select * from table1 group by col1, col2 having col1 = col2",
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
    end
  
    def test_select_rollup_clause_parseable
      same_ast? "select * from table1 group by rollup(col1, col2)",
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
      same_ast? "select * from table1 group by cube(col1, col2)",
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
      same_ast? "select * from table1 for update",
        Ast::SelectStatement[
          :subquery => generate_ast("select * from table1").subquery,
          :for_update_clause => Ast::ForUpdateClause[{}]
        ]
    end
  
    def test_select_for_update_clause_column_parseable
      same_ast? "select * from table1 for update of column1",
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
      same_ast? "select * from table1 for update of table1.column1",
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
      same_ast? "select * from table1 for update of schema1.table1.column1",
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
      same_ast? "select * from table1 for update nowait",
        Ast::SelectStatement[
          :subquery => generate_ast("select * from table1").subquery,
          :for_update_clause => Ast::ForUpdateClause[
            :wait => Ast::Keyword[:name => 'nowait']
          ]
        ]
    end
  
    def test_select_for_update_clause_wait_parseable
      same_ast? "select * from table1 for update wait 1",
        Ast::SelectStatement[
          :subquery => generate_ast("select * from table1").subquery,
          :for_update_clause => Ast::ForUpdateClause[
            :wait => Ast::NumberLiteral[:value => '1']
          ]
        ]
    end
  
    def test_select_order_by_clause_expr_parseable
      same_ast? "select * from table1 order by col1",
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
      same_ast? "select * from table1 order by 1",
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
      same_ast? "select * from table1 order siblings by 1",
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
      same_ast? "select * from table1 order by col1 asc",
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
      same_ast? "select * from table1 order by col1 desc",
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
      same_ast? "select * from table1 order by col1 nulls first",
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
      same_ast? "select * from table1 order by col1 nulls last",
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
      same_ast? "select * from table1 order by col1 asc, col2 desc",
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
  end
end
