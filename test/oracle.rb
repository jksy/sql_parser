require File.expand_path('test_helper.rb', File.dirname(__FILE__))
require 'sql_parser'

class OracleTest < Test::Unit::TestCase
  def setup
  end

  def enable_debug
   indent = 0
   method_names = SqlParser::OracleParser.instance_methods.grep(/_nt_.*/)
   method_names.each do |name|
     SqlParser::OracleParser.send(:define_method, "#{name}_new") do
       indent = indent + 1
       puts(" " * indent + name.to_s + ":#{index}")
       result = send("#{name}_old")
       indent = indent - 1
       result
     end
     SqlParser::OracleParser.class_eval do
       alias_method "#{name}_old", "#{name}"
       alias_method "#{name}", "#{name}_new"
     end
   end
  end

  def teardown
  end

  def parse_successful(query)
    parser = SqlParser::OracleParser.new
    result = parser.parse query
    if result.nil?
      message = "\n#{query}\n" + " " * (parser.failure_column.to_i-1) + "*\n" 
      raise parser.failure_reason + message
    end
  end

  def test_select_parseable
    parse_successful 'select col1 from table1'
  end

  def test_select_plural_column_parseable
    parse_successful 'select col1, col2 from table1'
  end

  def test_select_literal_number_column_parseable
    parse_successful 'select 1 from table1'
  end

  def test_select_literal_nagative_number_column_parseable
    parse_successful 'select -1 from table1'
  end

  def test_select_literal_float_number_column_parseable
    parse_successful 'select 1.1 from table1'
  end

  def test_select_literal_float_nagavite_number_column_parseable
    parse_successful 'select -1.1 from table1'
  end

  def test_select_literal_string_parseable
    parse_successful "select 'adslfael' from table1"
  end

  def test_select_asterisk_parseable
    parse_successful "select * from table1"
  end

  def test_select_table_and_asterisk_parseable
    parse_successful "select table1.* from table1"
  end

  def test_select_where_parseable
    parse_successful "select * from table1 where col1 = col1"
  end

  def test_select_where_with_literal_textparseable
    parse_successful "select * from table1 where col1 = 'abc'"
  end

  def test_select_where_with_literal_number_parseable
    parse_successful "select * from table1 where col1 = -1"
  end

  def test_select_where_with_neq1_parseable
    parse_successful "select * from table1 where col1 != 1"
  end

  def test_select_where_with_neq2_parseable
    parse_successful "select * from table1 where col1 ^= 1"
  end

  def test_select_where_with_neq3_parseable
    parse_successful "select * from table1 where col1 <> 1"
  end

  def test_select_where_with_less_equal_parseable
    parse_successful "select * from table1 where col1 <= 1"
  end

  def test_select_where_with_grater_equal_parseable
    parse_successful "select * from table1 where col1 >= 1"
  end

  def test_select_where_with_logical_and_conditions_parseable
    parse_successful "select * from table1 where col1 = col2 and col3 = col4"
  end

  def test_select_where_with_logical_or_conditions_parseable
    parse_successful "select * from table1 where col1 = col2 or col3 = col4"
  end

  def test_select_where_with_like_onditions_parseable
    parse_successful "select * from table1 where col1 like 'abc%'"
  end

  def test_select_where_with_likec_onditions_parseable
    parse_successful "select * from table1 where col1 likec 'abc%'"
  end

  def test_select_where_with_like2_onditions_parseable
    parse_successful "select * from table1 where col1 like2 'abc%'"
  end

  def test_select_where_with_like4_onditions_parseable
    parse_successful "select * from table1 where col1 like4 'abc%'"
  end

  def test_select_where_with_not_like_onditions_parseable
    parse_successful "select * from table1 where col1 not like 'abc%'"
  end

  def test_select_where_with_like_escape_conditions_parseable
    parse_successful "select * from table1 where col1 like 'abc%'  escape '\'"
  end

  def test_select_where_with_regexp_like_conditions_parseable
    parse_successful "select * from table1 where regexp_like(col1,  '^Ste(v|ph)en$')"
  end

  def test_select_where_with_null_conditions_parseable
    parse_successful "select * from table1 where col1 is null"
  end

  def test_select_where_with_not_null_conditions_parseable
    parse_successful "select * from table1 where col1 is not null"
  end

  def test_select_where_with_compodition_conditions_parseable
    parse_successful "select * from table1 where (col1 = col2)"
  end

  def test_select_where_with_compodition_not_conditions_parseable
    parse_successful "select * from table1 where not col1 = col2"
  end

  def test_select_where_with_between_conditions_parseable
    parse_successful "select * from table1 where col1 between col2 and col3"
  end

  def test_select_where_with_not_between_conditions_parseable
    parse_successful "select * from table1 where col1 not between col2 and col3"
  end

  def test_select_where_with_between_number_conditions_parseable
    parse_successful "select * from table1 where col1 between 1 and 100"
  end

  def test_select_where_with_between_string_conditions_parseable
    parse_successful "select * from table1 where col1 between 'a' and 'z'"
  end

  def test_select_where_with_exists_condition
    parse_successful "select * from table1 where exists (select 1 from table2 where col1 = 1)"
  end

  def test_select_where_with_not_exists_condition
    parse_successful "select * from table1 where not exists (select 1 from table2 where col1 = 1)"
  end

  def test_select_where_in_expr_condition
    parse_successful "select * from table1 where col1 in (1)"
  end

  def test_select_where_not_in_expr_condition
    parse_successful "select * from table1 where col1 not in (1)"
  end

  def test_select_where_in_subquery_condition
    parse_successful "select * from table1 where col1 in (select * from table2)"
  end

  def test_select_where_not_in_subquery_condition
    parse_successful "select * from table1 where col1 not in (select * from table2)"
  end

end
