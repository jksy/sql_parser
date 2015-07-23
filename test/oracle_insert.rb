require File.expand_path('test_helper.rb', File.dirname(__FILE__))

class OracleInsert < Base
  def test_insert_parseable
    same_ast? "insert into table1 values('1')",
      Ast::InsertStatement[
        :insert => Ast::Identifier[:name => 'table1'],
        :values => Ast::Array[
          Ast::TextLiteral[:value => '1']
        ]
      ]
  end

  def test_insert_plural_values_parseable
    same_ast? "insert into table1 values('1',1)",
      Ast::InsertStatement[
        :insert => Ast::Identifier[:name => 'table1'],
        :values => Ast::Array[
          Ast::TextLiteral[:value => '1'],
          Ast::NumberLiteral[:value => '1']
        ]
      ]
  end

  def test_insert_table_alias_parseable
    same_ast? "insert into table1 t_alias values('1')",
      Ast::InsertStatement[
        :insert => Ast::Identifier[:name => 'table1'],
        :values => Ast::Array[
          Ast::TextLiteral[:value => '1']
        ]
      ]
  end

  def test_insert_with_column_names_parseable
    same_ast? "insert into table1 t_alias (col1, col2) values('1',1)",
      Ast::InsertStatement[
        :insert => Ast::Identifier[:name => 'table1'],
        :columns => Ast::Array[
          Ast::Identifier[:name => 'col1'],
          Ast::Identifier[:name => 'col2']
        ],
        :values => Ast::Array[
          Ast::TextLiteral[:value => '1'],
          Ast::NumberLiteral[:value => '1']
        ]
      ]
  end

  def test_insert_values_default_parseable
    same_ast? "insert into table1 t_alias (col1, col2) values('1',default)",
      Ast::InsertStatement[
        :insert => Ast::Identifier[:name => 'table1'],
        :columns => Ast::Array[
          Ast::Identifier[:name => 'col1'],
          Ast::Identifier[:name => 'col2']
        ],
        :values => Ast::Array[
          Ast::TextLiteral[:value => '1'],
          Ast::Keyword[:name => 'default']
        ]
      ]
  end

  def test_insert_values_function_parseable
    same_ast? "insert into table1 t_alias (col1) values(to_char(sysdate, 'Day'))",
      Ast::InsertStatement[
        :insert => Ast::Identifier[:name => 'table1'],
        :columns => Ast::Array[
          Ast::Identifier[:name => 'col1'],
        ],
        :values => Ast::Array[
          Ast::FunctionExpressoin[
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
    same_ast? "insert into schema1.table1 (col1) values(0)",
      Ast::InsertStatement[
        :insert => Ast::Identifier[:name => 'schema1.table1'],
        :columns => Ast::Array[
          Ast::Identifier[:name => 'col1'],
        ],
        :values => Ast::Array[
          Ast::NumberLiteral[:value => '0']
        ]
      ]

  end

  def test_insert_schema_table_dblink_parseable
    same_ast? "insert into schema1.table1@dblink (col1) values(0)",
      Ast::InsertStatement[
        :insert => Ast::Identifier[:name => 'schema1.table1@dblink'],
        :columns => Ast::Array[
          Ast::Identifier[:name => 'col1'],
        ],
        :values => Ast::Array[
          Ast::NumberLiteral[:value => '0']
        ]
      ]
  end

end
