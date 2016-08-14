require File.expand_path('base_test.rb', File.dirname(__FILE__))

module Grammar
  class ExpressionTest < BaseTest
    def test_simple_expression_rownum_parseable
      assert_ast_sql_equal "select rownum from dual",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => Ast::Keyword[:name => 'rownum']
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name => Ast::Identifier[:name => 'dual']
                ]
              ]
            ],
          ],
        ]
    end

    def test_simple_expression_text_literal_parseable
      assert_ast_sql_equal "select 'asdlfjasldfja' from dual",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => Ast::TextLiteral[:value => 'asdlfjasldfja']
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name => Ast::Identifier[:name => 'dual']
                ]
              ]
            ],
          ],
        ]
    end

    def test_simple_expression_number_literal_parseable
      assert_ast_sql_equal "select 13123 from dual",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => Ast::NumberLiteral[:value => '13123']
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name => Ast::Identifier[:name => 'dual']
                ]
              ]
            ],
          ],
        ]
    end

    def test_simple_expression_sequence_nextval_parseable
      assert_ast_sql_equal "select sequence_name.nextval from dual",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => Ast::Identifier[:name => 'sequence_name.nextval']
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name => Ast::Identifier[:name => 'dual']
                ]
              ]
            ],
          ],
        ]
    end

    def test_simple_expression_sequence_currval_parseable
      assert_ast_sql_equal "select sequence_name.currval from dual",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => Ast::Identifier[:name => 'sequence_name.currval']
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name => Ast::Identifier[:name => 'dual']
                ]
              ]
            ],
          ],
        ]
    end

    def test_simple_expression_null_parseable
      assert_ast_sql_equal "select null from dual",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => Ast::Keyword[:name => 'null']
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name => Ast::Identifier[:name => 'dual']
                ]
              ]
            ],
          ],
        ]
    end

    def test_simple_expression_column_by_schema_table_column_parseable
      assert_ast_sql_equal "select schema1.table1.column1 from dual",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => Ast::Identifier[:name => 'schema1.table1.column1']
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name => Ast::Identifier[:name => 'dual']
                ]
              ]
            ],
          ],
        ]
    end

    def test_simple_expression_column_by_table_column_parseable
      assert_ast_sql_equal "select table1.column1 from dual",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => Ast::Identifier[:name => 'table1.column1']
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name => Ast::Identifier[:name => 'dual']
                ]
              ]
            ],
          ],
        ]
    end

    def test_simple_expression_column_by_column_parseable
      assert_ast_sql_equal "select column1 from dual",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => Ast::Identifier[:name => 'column1']
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name => Ast::Identifier[:name => 'dual']
                ]
              ]
            ],
          ],
        ]
    end

    def test_simple_expression_column_by_rowid_parseable
      assert_ast_sql_equal "select rowid from dual",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => Ast::Identifier[:name => 'rowid']
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name => Ast::Identifier[:name => 'dual']
                ]
              ]
            ],
          ],
        ]
    end

    def test_simple_case_expression_parseable
      assert_ast_sql_equal "select case credit_limit when 100 then 'low' when 5000 then 'high' end from customers",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => Ast::SimpleCaseExpression[
                    :condition => Ast::Identifier[:name => 'credit_limit'],
                    :when_clauses => Ast::Array[
                      Ast::Hash[
                        :when_expr => Ast::NumberLiteral[:value=>'100'],
                        :return_expr => Ast::TextLiteral[:value=>'low']
                      ],
                      Ast::Hash[
                        :when_expr => Ast::NumberLiteral[:value=>'5000'],
                        :return_expr => Ast::TextLiteral[:value=>'high']
                      ]
                    ]
                  ]
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name => Ast::Identifier[:name => 'customers']
                ]
              ]
            ]
          ]
        ]
    end

    def test_simple_case_expression_else_parseable
      assert_ast_sql_equal "select case credit_limit when 100 then 'low' when 5000 then 'high' else 'medium' end from customers",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => Ast::SimpleCaseExpression[
                    :condition => Ast::Identifier[:name => 'credit_limit'],
                    :when_clauses => Ast::Array[
                      Ast::Hash[
                        :when_expr => Ast::NumberLiteral[:value=>'100'],
                        :return_expr => Ast::TextLiteral[:value=>'low']
                      ],
                      Ast::Hash[
                        :when_expr => Ast::NumberLiteral[:value=>'5000'],
                        :return_expr => Ast::TextLiteral[:value=>'high']
                      ]
                    ],
                    :else_clause => Ast::TextLiteral[:value => 'medium']
                  ]
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name => Ast::Identifier[:name => 'customers']
                ]
              ]
            ]
          ]
        ]
    end

    def test_searched_case_expression_else_parseable
      assert_ast_sql_equal "select case when salary > 2000 then salary else 2001 end from customers",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => Ast::SearchedCaseExpression[
                    :when_condition => Ast::SimpleComparisionCondition[
                      :left => Ast::Identifier[:name => 'salary'],
                      :op => '>',
                      :right => Ast::NumberLiteral[:value => '2000']
                    ],
                    :return_expr => Ast::Identifier[:name=>'salary'],
                    :else_clause => Ast::NumberLiteral[:value => '2001']
                  ]
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name => Ast::Identifier[:name => 'customers']
                ]
              ]
            ]
          ]
        ]
    end

    def test_function_expression_no_args_parseable
      assert_ast_sql_equal "select func() from dual",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => Ast::FunctionExpression[
                    :name => Ast::Identifier[:name =>'func'],
                  ]
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name => Ast::Identifier[:name => 'dual']
                ]
              ]
            ],
          ]
        ]
    end

    def test_function_expression_one_args_parseable
      assert_ast_sql_equal "select one_arg_function(col1) from customers",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => Ast::FunctionExpression[
                    :name => Ast::Identifier[:name => 'one_arg_function'],
                    :args => Ast::Array[
                      Ast::Identifier[:name => 'col1']
                    ],
                  ]
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name => Ast::Identifier[:name => 'customers']
                ]
              ]
            ],
          ]
        ]
    end

    def test_function_expression_two_args_parseable
      assert_ast_sql_equal "select two_args_function(1,'0') from dual",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => Ast::FunctionExpression[
                    :name => Ast::Identifier[:name => 'two_args_function'],
                    :args => Ast::Array[
                      Ast::NumberLiteral[:value => '1'],
                      Ast::TextLiteral[:value => '0'],
                    ],
                  ]
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name => Ast::Identifier[:name => 'dual']
                ]
              ]
            ],
          ]
        ]
    end

    def test_function_expression_package_name_parseable
      assert_ast_sql_equal "select package_name.procedure_name(col1) from customers",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => Ast::FunctionExpression[
                    :name => Ast::Identifier[:name => 'package_name.procedure_name'],
                    :args => Ast::Array[
                      Ast::Identifier[:name => 'col1'],
                    ],
                  ]
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name => Ast::Identifier[:name => 'customers']
                ]
              ]
            ],
          ]
        ]
    end

    def test_function_expression_function_in_args_parseable
      assert_ast_sql_equal "select to_date(to_char(sysdate,'yyyy/mm/dd hh24:mi:ss')) from dual",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => Ast::FunctionExpression[
                    :name => Ast::Identifier[:name => 'to_date'],
                    :args => Ast::Array[
                      Ast::FunctionExpression[
                        :name => Ast::Identifier[:name => 'to_char'],
                        :args => Ast::Array[
                          Ast::Keyword[:name => 'sysdate'],
                          Ast::TextLiteral[:value => 'yyyy/mm/dd hh24:mi:ss']
                        ]
                      ]
                    ],
                  ]
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name =>Ast::Identifier[:name => 'dual']
                ]
              ]
            ],
          ]
        ]
    end

    def test_must_parseable_with_parenthesis
      assert_ast_sql_equal "select ( 1 ) from dual",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => Ast::CompoundExpression[
                    :has_parenthesis => true,
                    :left => Ast::NumberLiteral[:value => "1"],
                  ],
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name =>Ast::Identifier[:name => 'dual']
                ]
              ]
            ],
          ]
        ]
    end

    def test_must_parseable_with_plus_operator
      assert_ast_sql_equal "select 1 + 1 from dual",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => Ast::CompoundExpression[
                    :left => Ast::NumberLiteral[:value => "1"],
                    :op => Ast::Base["+"],
                    :right => Ast::NumberLiteral[:value => "1"],
                  ],
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name =>Ast::Identifier[:name => 'dual']
                ]
              ]
            ],
          ]
        ]
    end

    def test_must_parseable_with_multiplicatoin
      assert_ast_sql_equal "select 1 * 1 from dual",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => Ast::CompoundExpression[
                    :left => Ast::NumberLiteral[:value => "1"],
                    :op => Ast::Base["*"],
                    :right => Ast::NumberLiteral[:value => "1"],
                  ],
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name =>Ast::Identifier[:name => 'dual']
                ]
              ]
            ],
          ]
        ]
    end

    def test_must_parseable_with_division
      assert_ast_sql_equal "select 1 / 1 from dual",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => Ast::CompoundExpression[
                    :left => Ast::NumberLiteral[:value => "1"],
                    :op => Ast::Base["/"],
                    :right => Ast::NumberLiteral[:value => "1"],
                  ],
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name =>Ast::Identifier[:name => 'dual']
                ]
              ]
            ],
          ]
        ]
    end

    def test_must_parseable_with_plus
      assert_ast_sql_equal "select 1 + 1 from dual",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => Ast::CompoundExpression[
                    :left => Ast::NumberLiteral[:value => "1"],
                    :op => Ast::Base["+"],
                    :right => Ast::NumberLiteral[:value => "1"],
                  ],
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name =>Ast::Identifier[:name => 'dual']
                ]
              ]
            ],
          ]
        ]
    end

    def test_must_parseable_with_minus
      assert_ast_sql_equal "select 1 - 1 from dual",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => Ast::CompoundExpression[
                    :left => Ast::NumberLiteral[:value => "1"],
                    :op => Ast::Base["-"],
                    :right => Ast::NumberLiteral[:value => "1"],
                  ],
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name =>Ast::Identifier[:name => 'dual']
                ]
              ]
            ],
          ]
        ]
    end

    def test_must_parseable_with_concat
      assert_ast_sql_equal "select 'a' || 'b' from dual",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => Ast::CompoundExpression[
                    :left => Ast::TextLiteral[:value => "a"],
                    :op => Ast::Base["||"],
                    :right => Ast::TextLiteral[:value => "b"],
                  ],
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name =>Ast::Identifier[:name => 'dual']
                ]
              ]
            ],
          ]
        ]
    end

    def test_must_parseable_with_prefix_plus
      assert_ast_sql_equal "select + t.col1 from dual",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => Ast::CompoundExpression[
                    :op => Ast::Base["+"],
                    :right => Ast::Identifier[:name => "t.col1"],
                  ],
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name =>Ast::Identifier[:name => 'dual']
                ]
              ]
            ],
          ]
        ]
    end

    def test_must_parseable_with_prefix_minus
      assert_ast_sql_equal "select - t.col1 from dual",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => Ast::CompoundExpression[
                    :op => Ast::Base["-"],
                    :right => Ast::Identifier[:name => "t.col1"],
                  ],
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name =>Ast::Identifier[:name => 'dual']
                ]
              ]
            ],
          ]
        ]
    end

    def test_must_parseable_with_prior
      assert_ast_sql_equal "select prior t.col1 from dual",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => Ast::CompoundExpression[
                    :op => Ast::Keyword[:name => "prior"],
                    :right => Ast::Identifier[:name => "t.col1"],
                  ],
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name =>Ast::Identifier[:name => 'dual']
                ]
              ]
            ],
          ]
        ]
    end
  end
end
