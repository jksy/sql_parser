require File.expand_path('base_test.rb', File.dirname(__FILE__))
module Grammar
  class SelectForUpdateTest < BaseTest
    def test_select_for_update_clause_parseable
      assert_ast_sql_equal "select * from table1 for update",
        Ast::SelectStatement[
          :subquery => generate_ast("select * from table1").subquery,
          :for_update_clause => Ast::ForUpdateClause[{}]
        ]
    end

    def test_select_for_update_clause_column_parseable
      assert_ast_sql_equal "select * from table1 for update of column1",
        Ast::SelectStatement[
          :subquery => generate_ast("select * from table1").subquery,
          :for_update_clause => Ast::ForUpdateClause[
            :columns => Ast::Array[
              Ast::Identifier[:name => 'column1']
            ]
          ]
        ]
    end

    def test_select_for_update_clause_table_and_column_parseable
      assert_ast_sql_equal "select * from table1 for update of table1.column1",
        Ast::SelectStatement[
          :subquery => generate_ast("select * from table1").subquery,
          :for_update_clause => Ast::ForUpdateClause[
            :columns => Ast::Array[
              Ast::Identifier[:name => 'table1.column1']
            ]
          ]
        ]
    end

    def test_select_for_update_clause_schema_and_table_and_column_parseable
      assert_ast_sql_equal "select * from table1 for update of schema1.table1.column1",
        Ast::SelectStatement[
          :subquery => generate_ast("select * from table1").subquery,
          :for_update_clause => Ast::ForUpdateClause[
            :columns => Ast::Array[
              Ast::Identifier[:name => 'schema1.table1.column1']
            ]
          ]
        ]
    end

    def test_select_for_update_clause_nowait_parseable
      assert_ast_sql_equal "select * from table1 for update nowait",
        Ast::SelectStatement[
          :subquery => generate_ast("select * from table1").subquery,
          :for_update_clause => Ast::ForUpdateClause[
            :wait => Ast::Keyword[:name => 'nowait']
          ]
        ]
    end

    def test_select_for_update_clause_wait_parseable
      assert_ast_sql_equal "select * from table1 for update wait 1",
        Ast::SelectStatement[
          :subquery => generate_ast("select * from table1").subquery,
          :for_update_clause => Ast::ForUpdateClause[
            :wait => Ast::Keyword[:name => 'wait'],
            :time => Ast::NumberLiteral[:value => '1']
          ]
        ]
    end
  end
end
