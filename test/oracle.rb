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

  def test_select_where_with_plural_conditions_parseable
    parsed = parser.parse "select * from table1 where col1 = col2 and col3 = col4"
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
