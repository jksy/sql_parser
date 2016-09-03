require File.expand_path('base_test.rb', File.dirname(__FILE__))

module Grammar
  class ExpressionTest < BaseTest
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
