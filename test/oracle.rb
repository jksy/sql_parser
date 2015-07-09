require File.expand_path('test_helper.rb', File.dirname(__FILE__))
require 'sql_parser'

class OracleTest < Test::Unit::TestCase
  def setup
  end

  def enable_debug
   indent = 0
   method_names = SqlParser::Oracle::OracleParser.instance_methods.grep(/_nt_.*/)
   method_names.each do |name|
     SqlParser::Oracle::OracleParser.send(:define_method, "#{name}_new") do
       indent = indent + 1
       parsing_text = "#{input[0..index-1]}*#{input[index..-1]}"
       puts(" " * indent + name.to_s + ":#{index}" + ": \t\t#{parsing_text}")
       result = send("#{name}_old")
       indent = indent - 1
       result
     end
     SqlParser::Oracle::OracleParser.class_eval do
       alias_method "#{name}_old", "#{name}"
       alias_method "#{name}", "#{name}_new"
     end
   end
  end

  def teardown
  end

  def parse_successful(query)
    parser = SqlParser::Oracle::OracleParser.new
    result = parser.parse query
    if result.nil?
      message = "\n#{query}\n" + " " * (parser.failure_column.to_i-1) + "*\n"
      raise parser.failure_reason + message
    end
  end

  # select
  def test_select_parseable
    parse_successful 'select col1 from table1'
  end

  def test_select_all_parseable
    parse_successful 'select all col1 from table1'
  end

  def test_select_distinct_parseable
    parse_successful 'select distinct col2 from table1'
  end

  def test_select_unique_parseable
    parse_successful 'select unique col2 from table1'
  end

  def test_select_union_parseable
    parse_successful 'select col1 from table1 union select col1 from table2'
  end

  def test_select_union_all_parseable
    parse_successful 'select col1 from table1 union all select col1 from table2'
  end

  def test_select_intersect_parseable
    parse_successful 'select col1 from table1 intersect select col1 from table2'
  end

  def test_select_minus_parseable
    parse_successful 'select col1 from table1 minus select col1 from table2'
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

  def test_join_clause_parseable
    parse_successful "select * from table1 inner join table2 on table1.col1 = table2.col1"
  end

  def test_inner_join_clause_with_on_parseable
    parse_successful "select * from table1 inner join table2 on table1.col1 = table2.col1"
  end

  def test_inner_join_clause_with_using_parseable
    parse_successful "select * from table1 inner join table2 using (col1, col2)"
  end

  def test_cross_join_clause_parseable
    parse_successful "select * from table1 cross join table2"
  end

  def test_cross_join_clause_with_natual_parseable
    parse_successful "select * from table1 natural join table2"
  end

  def test_cross_join_clause_with_natural_using_parseable
    parse_successful "select * from table1 natural inner join table2"
  end

  def test_outer_join_clause_full_join_parseable
    parse_successful "select * from table1 full outer join table2 on table1.col1 = table2.col2"
  end

  def test_outer_join_clause_left_join_parseable
    parse_successful "select * from table1 left join table2 on table1.col1 = table2.col2"
  end

  def test_outer_join_clause_right_join_parseable
    parse_successful "select * from table1 right join table2 on table1.col1 = table2.col2"
  end

  def test_outer_join_clause_natural_join_parseable
    parse_successful "select * from table1 natural join table2 on table1.col1 = table2.col2"
  end

  def test_outer_join_clause_natural_jointype_parseable
    parse_successful "select * from table1 natural left join table2 on table1.col1 = table2.col2"
  end

  def test_outer_join_clause_using_parseable
    parse_successful "select * from table1 natural left join table2 using (col1, col2)"
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

  def test_select_where_with_exists_condition_parseable
    parse_successful "select * from table1 where exists (select 1 from table2 where col1 = 1)"
  end

  def test_select_where_with_not_exists_condition_parseable
    parse_successful "select * from table1 where not exists (select 1 from table2 where col1 = 1)"
  end

  def test_select_where_in_expr_condition_parseable
    parse_successful "select * from table1 where col1 in (1)"
  end

  def test_select_where_not_in_expr_condition_parseable
    parse_successful "select * from table1 where col1 not in (1)"
  end

  def test_select_where_in_subquery_condition_parseable
    parse_successful "select * from table1 where col1 in (select * from table2)"
  end

  def test_select_where_not_in_subquery_condition_parseable
    parse_successful "select * from table1 where col1 not in (select * from table2)"
  end

  def test_select_group_by_expr_parseable
    parse_successful "select * from table1 group by col1, col2"
  end

  def test_select_group_by_having_condition_parseable
    parse_successful "select * from table1 group by col1, col2 having col1 = col2"
  end

  def test_select_rollup_clause_parseable
    parse_successful "select * from table1 group by rollup(col1, col2)"
  end

  def test_select_cube_clause_parseable
    parse_successful "select * from table1 group by cube(col1, col2)"
  end

  def test_select_for_update_clause_parseable
    parse_successful "select * from table1 for update"
  end

  def test_select_for_update_clause_column_parseable
    parse_successful "select * from table1 for update of column1"
  end

  def test_select_for_update_clause_table_and_column_parseable
    parse_successful "select * from table1 for update of table1.column1"
  end

  def test_select_for_update_clause_schema_and_table_and_column_parseable
    parse_successful "select * from table1 for update of schema1.table1.column1"
  end

  def test_select_for_update_clause_nowait_parseable
    parse_successful "select * from table1 for update nowait"
  end

  def test_select_for_update_clause_wait_parseable
    parse_successful "select * from table1 for update wait 1"
  end

  def test_select_order_by_clause_expr_parseable
    parse_successful "select * from table1 order by col1"
  end

  def test_select_order_by_clause_position_parseable
    parse_successful "select * from table1 order by 1"
  end

  def test_select_order_by_clause_siblings_parseable
    parse_successful "select * from table1 order siblings by 1"
  end

  def test_select_order_by_clause_asc_parseable
    parse_successful "select * from table1 order by col1 asc"
  end

  def test_select_order_by_clause_desc_parseable
    parse_successful "select * from table1 order by col1 desc"
  end

  def test_select_order_by_clause_nulls_first_parseable
    parse_successful "select * from table1 order by col1 nulls first"
  end

  def test_select_order_by_clause_nulls_last_parseable
    parse_successful "select * from table1 order by col1 nulls last"
  end

  def test_select_order_by_clause_plural_column_parseable
    parse_successful "select * from table1 order by col1 asc, col2 desc"
  end

  # update
  def test_update_parseable
    parse_successful "update table1 set col1 = 1"
  end

  def test_update_plural_column_parseable
    parse_successful "update table1 set col1 = 1, col2 = 2"
  end

  def test_update_condition_parseable
    parse_successful "update table1 set col1 = 1 where col2 = 1"
  end

  def test_update_current_of_condition_parseable
    parse_successful "update table1 set col1 = 1 where current_of cursor_name"
  end

  # expression
  def test_simple_expression_rownum_parseable
    parse_successful "select rownum from dual"
  end

  def test_simple_expression_text_literal_parseable
    parse_successful "select 'asdlfjasldfja' from dual"
  end

  def test_simple_expression_number_literal_parseable
    parse_successful "select 13123 from dual"
  end

  def test_simple_expression_sequence_nextval_parseable
    parse_successful "select sequence_name.nextval from dual"
  end

  def test_simple_expression_sequence_currval_parseable
    parse_successful "select sequence_name.currval from dual"
  end

  def test_simple_expression_null_parseable
    parse_successful "select null from dual"
  end

  def test_simple_expression_column_by_schema_table_column_parseable
    parse_successful "select schema1.table1.column1 from dual"
  end

  def test_simple_expression_column_by_table_column_parseable
    parse_successful "select table1.column1 from dual"
  end

  def test_simple_expression_column_by_column_parseable
    parse_successful "select column1 from dual"
  end

  def test_simple_expression_column_by_rowid_parseable
    parse_successful "select rowid from dual"
  end

  def test_simple_case_expression_parseable
    parse_successful "select case credit_limit when 100 then 'low' when 5000 then 'high' end from customers"
  end

  def test_simple_case_expression_else_parseable
    parse_successful "select case credit_limit when 100 then 'low' when 5000 then 'high' else 'medium' end from customers"
  end

  def test_searched_case_expression_else_parseable
    parse_successful "select case when salary > 2000 then salary else 2000 end from customers"
  end

  def test_function_expression_no_args_parseable
    parse_successful "select func() from dual"
  end

  def test_function_expression_one_args_parseable
    parse_successful "select one_arg_function(col1) from customers"
  end

  def test_function_expression_two_args_parseable
    parse_successful "select two_args_function(1, '0') from dual"
  end

  def test_function_expression_package_name_parseable
    parse_successful "select package_name.procedure_name(col1) from customers"
  end

  # delete
  def test_delete_parseable
    parse_successful "delete from table1"
  end

  def test_delete_target_table_reference_parseable
    parse_successful "delete from table1"
  end

  def test_delete_target_table_subquery_parseable
    parse_successful "delete from (select 1 from dual)"
  end

  def test_delete_target_table_keyword_parseable
    parse_successful "delete from table (select 1 from dual)"
  end

  def test_delete_target_alias_parseable
    parse_successful "delete from table1 table_alias"
  end

  def test_delete_condition_with_search_condition_parseable
    parse_successful "delete from table1 where col1 = 1"
  end

  def test_delete_condition_with_current_of_parseable
    parse_successful "delete from table1 where current_of cursor_name"
  end
end
