require File.expand_path('test_helper.rb', File.dirname(__FILE__))
require 'sql_parser'

class OracleTest < Test::Unit::TestCase
  def setup
  end

  def teardown
  end

  def test_select_parseable
    parsed = parser.parse 'select col1 from table1'
    puts parsed
  end

  def test_select_plural_column_parseable
    parsed = parser.parse 'select col1, col2 from table1'
    puts parsed
  end

  def test_select_literal_number_column_parseable
    parsed = parser.parse 'select 1 from table1'
    puts parsed
  end

  def test_select_literal_nagative_number_column_parseable
    parsed = parser.parse 'select -1 from table1'
    puts parsed
  end

  def test_select_literal_float_number_column_parseable
    parsed = parser.parse 'select 1.1 from table1'
    puts parsed
  end

  def test_select_literal_float_nagavite_number_column_parseable
    parsed = parser.parse 'select -1.1 from table1'
    puts parsed
  end

  def test_select_literal_string_parseable
    parsed = parser.parse "select 'adslfael' from table1"
    puts parsed
  end

  def test_select_asterisk_parseable
    parsed = parser.parse "select * from table1"
    puts parsed
  end

  def test_select_table_and_asterisk_parseable
    parsed = parser.parse "select table1.* from table1"
    puts parsed
  end

  def test_select_where_parseable
    parsed = parser.parse "select * from table1 where col1 = col1"
    puts parsed
  end

  def test_select_where_with_literal_textparseable
    parsed = parser.parse "select * from table1 where col1 = 'abc'"
    puts parsed
  end

  def test_select_where_with_literal_number_parseable
    parsed = parser.parse "select * from table1 where col1 = -1"
    puts parsed
  end

  def test_select_where_with_logical_and_conditions_parseable
    parsed = parser.parse "select * from table1 where col1 = col2 and col3 = col4"
    puts parsed
  end

  def test_select_where_with_logical_or_conditions_parseable
    parsed = parser.parse "select * from table1 where col1 = col2 or col3 = col4"
    puts parsed
  end

  def test_select_where_with_like_onditions_parseable
    parsed = parser.parse "select * from table1 where col1 like 'abc%'"
    puts parsed
  end

  def test_select_where_with_likec_onditions_parseable
    parsed = parser.parse "select * from table1 where col1 likec 'abc%'"
    puts parsed
  end

  def test_select_where_with_like2_onditions_parseable
    parsed = parser.parse "select * from table1 where col1 like2 'abc%'"
    puts parsed
  end

  def test_select_where_with_like4_onditions_parseable
    parsed = parser.parse "select * from table1 where col1 like4 'abc%'"
    puts parsed
  end

  def test_select_where_with_not_like_onditions_parseable
    parsed = parser.parse "select * from table1 where col1 not like 'abc%'"
    puts parsed
  end

  def test_select_where_with_like_escape_conditions_parseable
    parsed = parser.parse "select * from table1 where col1 like 'abc%'  escape '\\'"
    puts parsed
  end

  def test_select_where_with_regexp_like_conditions_parseable
    parsed = parser.parse "select * from table1 where regexp_like(col1,  '^Ste(v|ph)en$')"
    puts parsed
  end

  def test_select_where_with_null_conditions_parseable
    parsed = parser.parse "select * from table1 where col1 is null"
    puts parsed
  end

  def test_select_where_with_not_null_conditions_parseable
    parsed = parser.parse "select * from table1 where col1 is not null"
    puts parsed
  end

  def test_select_where_with_compodition_conditions_parseable
    parsed = parser.parse "select * from table1 where (col1 = col2)"
    puts parsed
  end

  def test_select_where_with_compodition_not_conditions_parseable
    parsed = parser.parse "select * from table1 where not col1 = col2"
    puts parsed
  end

  def test_select_where_with_between_conditions_parseable
    parsed = parser.parse "select * from table1 where col1 between col2 and col3"
    puts parsed
  end

  def test_select_where_with_not_between_conditions_parseable
    parsed = parser.parse "select * from table1 where col1 not between col2 and col3"
    puts parsed
  end

  def test_select_where_with_between_number_conditions_parseable
    parsed = parser.parse "select * from table1 where col1 between 1 and 100"
    puts parsed
  end

  def test_select_where_with_between_string_conditions_parseable
    parsed = parser.parse "select * from table1 where col1 between 'a' and 'z'"
    puts parsed
  end

  def test_select_where_with_exists_condition
    parsed = parser.parse "select * from table1 where exists (select 1 from table2 where col1 = 1)"
    puts parsed
  end

  def test_select_where_with_not_exists_condition
    parsed = parser.parse "select * from table1 where not exists (select 1 from table2 where col1 = 1)"
    puts parsed
  end

  def parser
    unless @parser
      @parser = SqlParser::Oracle.new
#      @parser.yydebug = true
    end
    @parser
  end
end
