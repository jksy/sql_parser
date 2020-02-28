require File.expand_path('base_test.rb', File.dirname(__FILE__))

module Grammar
  class InsertTest < BaseTest
    def test_insert_parseable
      assert_ast_sql_equal "insert into table1 values('1')",
        Ast::InsertStatement[
          :insert => Ast::TableReference[
            :table_name => Ast::Identifier[:name => 'table1']
          ],
          :values => Ast::InsertValuesClause[
            Ast::TextLiteral[:value => '1']
          ]
        ]
    end

    def test_insert_plural_values_parseable
      assert_ast_sql_equal "insert into table1 values('1',1)",
        Ast::InsertStatement[
          :insert => Ast::TableReference[
            :table_name => Ast::Identifier[:name => 'table1']
          ],
          :values => Ast::InsertValuesClause[
            Ast::TextLiteral[:value => '1'],
            Ast::NumberLiteral[:value => '1']
          ]
        ]
    end

    def test_insert_table_alias_parseable
      assert_ast_sql_equal "insert into table1 t_alias values('1')",
        Ast::InsertStatement[
          :insert => Ast::TableReference[
            :table_name => Ast::Identifier[:name => 'table1'],
            :table_alias =>  Ast::Identifier[:name => 't_alias']
          ],
          :values => Ast::InsertValuesClause[
            Ast::TextLiteral[:value => '1']
          ]
        ]
    end

    def test_insert_with_column_names_parseable
      assert_ast_sql_equal "insert into table1 t_alias (col1,col2) values('1',1)",
        Ast::InsertStatement[
          :insert => Ast::TableReference[
            :table_name => Ast::Identifier[:name => 'table1'],
            :table_alias => Ast::Identifier[:name => 't_alias'],
          ],
          :columns => Ast::Array[
            Ast::Identifier[:name => 'col1'],
            Ast::Identifier[:name => 'col2']
          ],
          :values => Ast::InsertValuesClause[
            Ast::TextLiteral[:value => '1'],
            Ast::NumberLiteral[:value => '1']
          ]
        ]
    end

    def test_insert_values_default_parseable
      assert_ast_sql_equal "insert into table1 t_alias (col1,col2) values('1',default)",
        Ast::InsertStatement[
          :insert => Ast::TableReference[
            :table_name => Ast::Identifier[:name => 'table1'],
            :table_alias => Ast::Identifier[:name => 't_alias'],
          ],
          :columns => Ast::Array[
            Ast::Identifier[:name => 'col1'],
            Ast::Identifier[:name => 'col2']
          ],
          :values => Ast::InsertValuesClause[
            Ast::TextLiteral[:value => '1'],
            Ast::Keyword[:name => 'default']
          ]
        ]
    end

    def test_insert_values_function_parseable
      assert_ast_sql_equal "insert into table1 t_alias (col1) values(to_char(sysdate,'Day'))",
        Ast::InsertStatement[
          :insert => Ast::TableReference[
            :table_name => Ast::Identifier[:name => 'table1'],
            :table_alias => Ast::Identifier[:name => 't_alias'],
          ],
          :columns => Ast::Array[
            Ast::Identifier[:name => 'col1'],
          ],
          :values => Ast::InsertValuesClause[
            Ast::FunctionExpression[
              :name => Ast::Identifier[:name => 'to_char'],
              :args => Ast::Array[
                Ast::Keyword[:name => 'sysdate'],
                Ast::TextLiteral[:value => 'Day']
              ]
            ]
          ]
        ]
    end

    def test_insert_schema_table_parseable
      assert_ast_sql_equal "insert into schema1.table1 (col1) values(0)",
        Ast::InsertStatement[
          :insert => Ast::TableReference[
            :schema_name => Ast::Identifier[:name => 'schema1'],
            :table_name => Ast::Identifier[:name => 'table1'],
          ],
          :columns => Ast::Array[
            Ast::Identifier[:name => 'col1'],
          ],
          :values => Ast::InsertValuesClause[
            Ast::NumberLiteral[:value => '0']
          ]
        ]
    end

    def test_insert_schema_table_dblink_parseable
      assert_ast_sql_equal "insert into schema1.table1@dblink (col1) values(0)",
        Ast::InsertStatement[
          :insert => Ast::TableReference[
            :schema_name => Ast::Identifier[:name => 'schema1'],
            :table_name => Ast::Identifier[:name => 'table1'],
            :dblink => Ast::Identifier[:name => 'dblink'],
          ],
          :columns => Ast::Array[
            Ast::Identifier[:name => 'col1'],
          ],
          :values => Ast::InsertValuesClause[
            Ast::NumberLiteral[:value => '0']
          ]
        ]
    end
  end
end
