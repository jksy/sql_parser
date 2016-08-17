require File.expand_path('base_test.rb', File.dirname(__FILE__))

module Grammar
  class ExpressionCaseTest < BaseTest
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
                    :when_condition => Ast::SimpleComparisonCondition[
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

  end
end
