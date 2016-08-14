require File.expand_path('base_test.rb', File.dirname(__FILE__))
module Grammar
  class SelectUnionTest < BaseTest
    def test_select_union_parseable
      assert_ast_sql_equal 'select col1 from table1 union select col2 from table2',
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :subqueries => Ast::Array[
              Ast::QueryBlock[
                :select_list => Ast::Array[
                  Ast::SelectColumn[
                    :expr => Ast::Identifier[:name => 'col1']
                  ]
                ],
                :select_sources => Ast::Array[
                  Ast::TableReference[:table_name => Ast::Identifier[:name => 'table1']]
                ]
              ],
              Ast::Array[
                Ast::Keyword[:name => 'union']
              ],
              Ast::Subquery[
                :query_block => Ast::QueryBlock[
                  :select_list => Ast::Array[
                    Ast::SelectColumn[
                      :expr => Ast::Identifier[:name => 'col2']
                    ]
                  ],
                  :select_sources => Ast::Array[
                    Ast::TableReference[:table_name => Ast::Identifier[:name => 'table2']]
                  ]
                ],
              ],
            ]
          ]
        ]
    end

    def test_select_union_with_parentheses_parseable
      assert_ast_sql_equal 'select col1 from table1 union ( select col2 from table2 )',
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :subqueries => Ast::Array[
              Ast::QueryBlock[
                :select_list => Ast::Array[
                  Ast::SelectColumn[
                    :expr => Ast::Identifier[:name => 'col1']
                  ]
                ],
                :select_sources => Ast::Array[
                  Ast::TableReference[:table_name => Ast::Identifier[:name => 'table1']]
                ]
              ],
              Ast::Array[
                Ast::Keyword[:name => 'union']
              ],
              Ast::Subquery[
                :has_parenthesis => true,
                :subquery => Ast::Subquery[
                  :query_block => Ast::QueryBlock[
                    :select_list => Ast::Array[
                      Ast::SelectColumn[
                        :expr => Ast::Identifier[:name => 'col2']
                      ]
                    ],
                    :select_sources => Ast::Array[
                      Ast::TableReference[:table_name => Ast::Identifier[:name => 'table2']]
                    ]
                  ],
                ]
              ],
            ]
          ]
        ]
    end

    def test_select_multiple_union_parseable
      assert_ast_sql_equal 'select col1 from table1 union select col2 from table2 union select col3 from table3',
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :subqueries => Ast::Array[
              generate_ast("select col1 from table1").subquery.query_block,
              Ast::Array[
                Ast::Keyword[:name => 'union']
              ],
              generate_ast("select col2 from table2 union select col3 from table3").subquery,
            ]
          ]
        ]
    end

    def test_select_union_all_parseable
      assert_ast_sql_equal 'select col1 from table1 union all select col2 from table2',
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :subqueries => Ast::Array[
              generate_ast("select col1 from table1").subquery.query_block,
              Ast::Array[
                Ast::Keyword[:name => 'union'],
                Ast::Keyword[:name => 'all']
              ],
              generate_ast("select col2 from table2").subquery,
            ]
          ]
        ]
    end

    def test_select_intersect_parseable
      assert_ast_sql_equal 'select col1 from table1 intersect select col2 from table2',
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :subqueries => Ast::Array[
              generate_ast('select col1 from table1').subquery.query_block,
              Ast::Array[
                Ast::Keyword[:name => 'intersect']
              ],
              generate_ast('select col2 from table2').subquery,
            ]
          ]
        ]
    end

    def test_select_minus_parseable
      assert_ast_sql_equal 'select col1 from table1 minus select col2 from table2',
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :subqueries => Ast::Array[
              generate_ast('select col1 from table1').subquery.query_block,
              Ast::Array[
                Ast::Keyword[:name => 'minus']
              ],
              generate_ast('select col2 from table2').subquery
            ]
          ]
        ]
    end
  end
end
