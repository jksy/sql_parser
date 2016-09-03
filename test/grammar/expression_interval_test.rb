require File.expand_path('base_test.rb', File.dirname(__FILE__))

module Grammar
  class ExpressionIntervalTest < BaseTest
    def test_day_parseable
      assert_ast_sql_equal "select ( SYSTIMESTAMP - order_date ) DAY TO SECOND from orders",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => OracleSqlParser::Ast::IntervalExpression[
                    :left => OracleSqlParser::Ast::Keyword[:name => 'SYSTIMESTAMP'],
                    :right => OracleSqlParser::Ast::Identifier[:name => 'order_date'],
                    :day => OracleSqlParser::Ast::Keyword[:name => 'DAY'],
                    :to => OracleSqlParser::Ast::Keyword[:name => 'TO'],
                    :second => OracleSqlParser::Ast::Keyword[:name => 'SECOND'],
                  ]
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name => Ast::Identifier[:name => 'orders']
                ]
              ]
            ]
          ]
        ]
    end

    def test_leading_field_precision_with_day_parseable
      assert_ast_sql_equal "select ( SYSTIMESTAMP - order_date ) DAY ( 9 ) TO SECOND from orders",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => OracleSqlParser::Ast::IntervalExpression[
                    :left => OracleSqlParser::Ast::Keyword[:name => 'SYSTIMESTAMP'],
                    :right => OracleSqlParser::Ast::Identifier[:name => 'order_date'],
                    :day => OracleSqlParser::Ast::Keyword[:name => 'DAY'],
                    :leading_field_precision => OracleSqlParser::Ast::NumberLiteral[:value => '9'],
                    :to => OracleSqlParser::Ast::Keyword[:name => 'TO'],
                    :second => OracleSqlParser::Ast::Keyword[:name => 'SECOND'],
                  ]
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name => Ast::Identifier[:name => 'orders']
                ]
              ]
            ]
          ]
        ]
    end

    def test_fractional_second_precision_with_day_parseable
      assert_ast_sql_equal "select ( SYSTIMESTAMP - order_date ) DAY ( 9 ) TO SECOND ( 0 ) from orders",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => OracleSqlParser::Ast::IntervalExpression[
                    :left => OracleSqlParser::Ast::Keyword[:name => 'SYSTIMESTAMP'],
                    :right => OracleSqlParser::Ast::Identifier[:name => 'order_date'],
                    :day => OracleSqlParser::Ast::Keyword[:name => 'DAY'],
                    :leading_field_precision => OracleSqlParser::Ast::NumberLiteral[:value => '9'],
                    :to => OracleSqlParser::Ast::Keyword[:name => 'TO'],
                    :second => OracleSqlParser::Ast::Keyword[:name => 'SECOND'],
                    :fractional_second_precision => OracleSqlParser::Ast::NumberLiteral[:value => '0'],
                  ]
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name => Ast::Identifier[:name => 'orders']
                ]
              ]
            ]
          ]
        ]
    end

    def test_year_parseable
      assert_ast_sql_equal "select ( SYSTIMESTAMP - order_date ) YEAR TO MONTH from orders",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => OracleSqlParser::Ast::IntervalExpression[
                    :left => OracleSqlParser::Ast::Keyword[:name => 'SYSTIMESTAMP'],
                    :right => OracleSqlParser::Ast::Identifier[:name => 'order_date'],
                    :year => OracleSqlParser::Ast::Keyword[:name => 'YEAR'],
                    :to => OracleSqlParser::Ast::Keyword[:name => 'TO'],
                    :month => OracleSqlParser::Ast::Keyword[:name => 'MONTH'],
                  ]
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name => Ast::Identifier[:name => 'orders']
                ]
              ]
            ]
          ]
        ]
    end

    def test_year_with_leading_field_precision_parseable
      assert_ast_sql_equal "select ( SYSTIMESTAMP - order_date ) YEAR ( 0 ) TO MONTH from orders",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => OracleSqlParser::Ast::IntervalExpression[
                    :left => OracleSqlParser::Ast::Keyword[:name => 'SYSTIMESTAMP'],
                    :right => OracleSqlParser::Ast::Identifier[:name => 'order_date'],
                    :year => OracleSqlParser::Ast::Keyword[:name => 'YEAR'],
                    :leading_field_precision => OracleSqlParser::Ast::NumberLiteral[:value => '0'],
                    :to => OracleSqlParser::Ast::Keyword[:name => 'TO'],
                    :month => OracleSqlParser::Ast::Keyword[:name => 'MONTH'],
                  ]
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name => Ast::Identifier[:name => 'orders']
                ]
              ]
            ]
          ]
        ]
    end

    def test_example_parseable
      assert_ast_sql_equal "select ( SYSTIMESTAMP - order_date ) DAY ( 9 ) TO SECOND from orders",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => OracleSqlParser::Ast::IntervalExpression[
                    :left => OracleSqlParser::Ast::Keyword[:name => 'SYSTIMESTAMP'],
                    :right => OracleSqlParser::Ast::Identifier[:name => 'order_date'],
                    :day => OracleSqlParser::Ast::Keyword[:name => 'DAY'],
                    :leading_field_precision => OracleSqlParser::Ast::NumberLiteral[:value => '9'],
                    :to => OracleSqlParser::Ast::Keyword[:name => 'TO'],
                    :second => OracleSqlParser::Ast::Keyword[:name => 'SECOND'],
                  ]
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name => Ast::Identifier[:name => 'orders']
                ]
              ]
            ]
          ]
        ]
    end

  end
end

