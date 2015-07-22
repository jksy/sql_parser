require File.expand_path('test_helper.rb', File.dirname(__FILE__))

class OracleInsert < Base
  def test_insert_parseable
    parse_successful "insert into table1 values('1')"
  end

  def test_insert_plural_values_parseable
    parse_successful "insert into table1 values('1',1)"
  end

  def test_insert_table_alias_parseable
    parse_successful "insert into table1 t_alias values('1')"
  end

  def test_insert_with_column_names_parseable
    parse_successful "insert into table1 t_alias (col1, col2) values('1',1)"
  end

  def test_insert_values_default_parseable
    parse_successful "insert into table1 t_alias (col1, col2) values('1',default)"
  end

  def test_insert_values_function_parseable
    parse_successful "insert into table1 t_alias (col1) values(to_char(sysdate, 'Day'))"
  end

  def test_insert_schema_table_parseable
    parse_successful "insert into schema.table1 (col1) values(0)"
  end

  def test_insert_schema_table_dblink_parseable
    parse_successful "insert into schema.table1@dblink (col1) values(0)"
  end

end
