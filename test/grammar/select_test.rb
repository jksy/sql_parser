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
                Ast::SelectColumn[
                  :expr => Ast::Identifier[:name => 'col1']
                ],
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[:table_name => Ast::Identifier[:name => 'table1']]
              ]
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
                Ast::SelectColumn[
                  :expr => Ast::Identifier[:name => 'col1'],
                ],
                Ast::SelectColumn[
                  :expr => Ast::Identifier[:name => 'col2'],
                ],
                Ast::SelectColumn[
                  :expr => Ast::Identifier[:name => 'col3']
                ],
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[:table_name => Ast::Identifier[:name => 'table1']]
              ]
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
                Ast::SelectColumn[
                  :expr => Ast::Identifier[:name => 'col1'],
                ],
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[:table_name => Ast::Identifier[:name => 'table1', :quoted => true]]
              ]
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
                Ast::SelectColumn[
                  :expr => Ast::Identifier[:name => 'col1']
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[:table_name => Ast::Identifier[:name => 'table1']]
              ]
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
                Ast::SelectColumn[
                  :expr => Ast::Identifier[:name => 'col2']
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[:table_name => Ast::Identifier[:name => 'table1']]
              ]
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
                Ast::SelectColumn[
                  :expr => Ast::Identifier[:name => 'col2']
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[:table_name => Ast::Identifier[:name => 'table1']]
              ]
            ]
          ]
        ]
      )
    end

    def test_select_literal_number_column_parseable
      assert_ast_sql_equal(
        'select 1 from table1',
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => Ast::NumberLiteral[:value => '1'],
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[:table_name => Ast::Identifier[:name => 'table1']]
              ]
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
                Ast::SelectColumn[
                  :expr => Ast::NumberLiteral[:value => '-1'],
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[:table_name => Ast::Identifier[:name => 'table1']]
              ]
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
                Ast::SelectColumn[
                  :expr => Ast::NumberLiteral[:value => '1.1'],
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[:table_name => Ast::Identifier[:name => 'table1']]
              ]
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
                Ast::SelectColumn[
                  :expr => Ast::NumberLiteral[:value => '-1.1']
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[:table_name => Ast::Identifier[:name => 'table1']]
              ]
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
                Ast::SelectColumn[
                  :expr => Ast::TextLiteral[:value => 'adslfael']
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[:table_name => Ast::Identifier[:name => 'table1']]
              ]
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
              :select_sources => Ast::Array[
                Ast::TableReference[:table_name => Ast::Identifier[:name => 'table1']]
              ]
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
                Ast::SelectColumn[
                    :expr => Ast::Identifier[:name => 'a'],
                    :as => Ast::Keyword[:name => "as"],
                    :c_alias => Ast::Identifier[:name => "b"],
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[:table_name => Ast::Identifier[:name => 'table1']]
              ]
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
              :select_sources => Ast::Array[
                Ast::TableReference[:table_name => Ast::Identifier[:name => 'table1']]
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
              :select_sources => Ast::Array[
                Ast::TableReference[:table_name => Ast::Identifier[:name => 'table1']],
              ],
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
              :select_sources => Ast::Array[
                Ast::TableReference[:table_name => Ast::Identifier[:name => 'table1']],
              ],
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

    def test_select_table_alias
      assert_ast_sql_equal "select a.* from table1 a",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => 'a.*']
              ],
              :select_sources => Ast::Array[
                OracleSqlParser::Ast::TableReference[
                  :table_name => OracleSqlParser::Ast::Identifier[:name => 'table1'],
                  :table_alias => OracleSqlParser::Ast::Identifier[:name => 'a'],
                ]
              ]
            ]
          ]
        ]
    end

    def test_select_multiple_table_alias
      assert_ast_sql_equal "select 1 from ( select 1 from books2 a ) x,( select 1 from books3 b ) y",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => Ast::NumberLiteral[:value => '1']
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :subquery => generate_ast("(select 1 from books2 a)").subquery,
                  :table_alias => Ast::Identifier[:name => 'x'],
                ],
                Ast::TableReference[
                  :subquery => generate_ast("(select 1 from books3 b)").subquery,
                  :table_alias => Ast::Identifier[:name => 'y'],
                ],
              ]
            ]
          ]
        ]
    end

    def test_select_with_compound_expression
      assert_ast_sql_equal %Q(select a.col - b.col as markup from RETAIL a,COST b),
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => Ast::CompoundExpression[
                    :left => Ast::Identifier[:name=>"a.col"],
                    :op => Ast::Base["-"],
                    :right => Ast::Identifier[:name=>"b.col"],
                  ],
                  :as => Ast::Keyword[:name=>"as"],
                  :c_alias => Ast::Identifier[:name=>"markup"],
                ],
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name => Ast::Identifier[:name => 'RETAIL'],
                  :table_alias => Ast::Identifier[:name => 'a'],
                ],
                Ast::TableReference[
                  :table_name => Ast::Identifier[:name => 'COST'],
                  :table_alias => Ast::Identifier[:name => 'b'],
                ]
              ]
            ]
          ]
        ]
    end
  end
end
