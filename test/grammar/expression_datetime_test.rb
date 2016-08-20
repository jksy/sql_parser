require File.expand_path('base_test.rb', File.dirname(__FILE__))

module Grammar
  class ExpressionDateTimeTest < BaseTest
    def test_datetime_expression_with_local_parseable
      assert_ast_sql_equal 'select column1 at local from dual',
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => Ast::DatetimeExpression[
                    :expr => Ast::Identifier[:name => 'column1'],
                    :at => Ast::Keyword[:name => 'at'],
                    :local => Ast::Keyword[:name => 'local'],
                  ],
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name => Ast::Identifier[:name => 'dual']
                ]
              ]
            ]
          ]
        ]
    end

    def test_datetime_expression_with_dbtimezone_parseable
      assert_ast_sql_equal 'select column1 at time zone dbtimezone from dual',
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => Ast::DatetimeExpression[
                    :expr => Ast::Identifier[:name => 'column1'],
                    :at => Ast::Keyword[:name => 'at'],
                    :timezone => Ast::TimezoneClause[
                      :time => Ast::Keyword[:name => 'time'],
                      :zone => Ast::Keyword[:name => 'zone'],
                      :expr => Ast::Keyword[:name => 'dbtimezone']
                    ],
                  ],
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name => Ast::Identifier[:name => 'dual']
                ]
              ]
            ]
          ]
        ]
    end

    def test_datetime_expression_with_sessiontimezone_parseable
      assert_ast_sql_equal 'select column1 at time zone sessiontimezone from dual',
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => Ast::DatetimeExpression[
                    :expr => Ast::Identifier[:name => 'column1'],
                    :at => Ast::Keyword[:name => 'at'],
                    :timezone => Ast::TimezoneClause[
                      :time => Ast::Keyword[:name => 'time'],
                      :zone => Ast::Keyword[:name => 'zone'],
                      :expr => Ast::Keyword[:name => 'sessiontimezone']
                    ],
                  ],
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name => Ast::Identifier[:name => 'dual']
                ]
              ]
            ]
          ]
        ]
    end

    def test_datetime_expression_with_utc_offset_parseable
      assert_ast_sql_equal "select column1 at time zone '+09:00' from dual",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => Ast::DatetimeExpression[
                    :expr => Ast::Identifier[:name => 'column1'],
                    :at => Ast::Keyword[:name => 'at'],
                    :timezone => Ast::TimezoneClause[
                      :time => Ast::Keyword[:name => 'time'],
                      :zone => Ast::Keyword[:name => 'zone'],
                      :expr => Ast::TextLiteral[:value => '+09:00']
                    ],
                  ],
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name => Ast::Identifier[:name => 'dual']
                ]
              ]
            ]
          ]
        ]
    end

    def test_datetime_expression_with_time_zone_name_parseable
      assert_ast_sql_equal "select column1 at time zone 'America/Los_Angeles' from dual",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => Ast::DatetimeExpression[
                    :expr => Ast::Identifier[:name => 'column1'],
                    :at => Ast::Keyword[:name => 'at'],
                    :timezone => Ast::TimezoneClause[
                      :time => Ast::Keyword[:name => 'time'],
                      :zone => Ast::Keyword[:name => 'zone'],
                      :expr => Ast::TextLiteral[:value => 'America/Los_Angeles']
                    ],
                  ],
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name => Ast::Identifier[:name => 'dual']
                ]
              ]
            ]
          ]
        ]
    end

    def test_datetime_expression_with_time_zone_expr_parseable
      assert_ast_sql_equal "select column1 at time zone column2 from dual",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => Ast::DatetimeExpression[
                    :expr => Ast::Identifier[:name => 'column1'],
                    :at => Ast::Keyword[:name => 'at'],
                    :timezone => Ast::TimezoneClause[
                      :time => Ast::Keyword[:name => 'time'],
                      :zone => Ast::Keyword[:name => 'zone'],
                      :expr => Ast::Identifier[:name => 'column2'],
                    ],
                  ],
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name => Ast::Identifier[:name => 'dual']
                ]
              ]
            ]
          ]
        ]
    end

  end
end

