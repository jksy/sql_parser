require File.expand_path('base_test.rb', File.dirname(__FILE__))

module Grammar
  class ExpressionFunctionTest < BaseTest
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
  end
end
