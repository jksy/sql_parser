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
  end
end
