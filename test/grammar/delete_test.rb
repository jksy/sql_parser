require File.expand_path('base_test.rb', File.dirname(__FILE__))

module Grammar
  class DeleteTest < BaseTest
    def test_delete_parseable
      assert_ast_sql_equal "delete from table1",
        Ast::DeleteStatement[
          :target => Ast::DeleteTarget[
            :name => Ast::TableReference[
              :table_name => Ast::Identifier[:name => 'table1']
            ]
          ]
        ]
    end

    def test_delete_target_table_reference_parseable
      assert_ast_sql_equal "delete from table1",
        Ast::DeleteStatement[
          :target => Ast::DeleteTarget[
            :name => Ast::TableReference[
              :table_name => Ast::Identifier[:name => 'table1']
            ]
          ]
        ]
    end

    def test_delete_target_table_subquery_parseable
      subquery_ast = generate_ast("select 1 from dual")
      assert_ast_sql_equal "delete from (select 1 from dual)",
        Ast::DeleteStatement[
          :target => Ast::DeleteTarget[
            :name => subquery_ast.subquery
          ]
        ]
    end

    def test_delete_target_table_keyword_parseable
      subquery_ast = generate_ast("select 1 from dual")
      assert_ast_sql_equal "delete from table (select 1 from dual)",
        Ast::DeleteStatement[
          :target => Ast::DeleteTarget[
            :name => subquery_ast.subquery,
            :table => Ast::Keyword[:name => 'table']
          ]
        ]
    end

    def test_delete_target_alias_parseable
      assert_ast_sql_equal "delete from table1 table_alias",
        Ast::DeleteStatement[
          :target => Ast::DeleteTarget[
            :name => Ast::TableReference[
              :table_name => Ast::Identifier[:name => 'table1'],
              :table_alias => Ast::Identifier[:name => 'table_alias'],
            ],
          ]
        ]
    end

    def test_delete_condition_with_search_condition_parseable
      where_clause_ast = generate_ast("select 1 from dual where col1 = 1").subquery.query_block.where_clause

      assert_ast_sql_equal "delete from table1 where col1 = 1",
        Ast::DeleteStatement[
          :target => Ast::DeleteTarget[
            :name => Ast::TableReference[
              :table_name =>Ast::Identifier[:name => 'table1']
            ],
          ],
          :where_clause => where_clause_ast
        ]
    end

    def test_delete_condition_with_current_of_parseable
      assert_ast_sql_equal "delete from table1 where current_of cursor_name",
        Ast::DeleteStatement[
          :target => Ast::DeleteTarget[
            :name => Ast::TableReference[
              :table_name => Ast::Identifier[:name => 'table1']
            ],
          ],
          :where_clause => Ast::WhereClause[
            :condition => Ast::CurrentOf[:cursor => Ast::Identifier[:name => 'cursor_name']]
          ]
        ]
    end
  end
end

