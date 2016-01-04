require File.expand_path('base_test.rb', File.dirname(__FILE__))

module OracleEnhancedAdapter
  class SelectTest < BaseTest

    def self.startup
      ActiveRecord::Base.establish_connection(BaseTest.connection_params)
      BaseTest.create_test_table
    end

    def assert_parameterized_equal(query, parameterized_query, params)
      ast = generate_ast(query)
      parameterized = ast.to_parameterized
      assert_equal(parameterized.to_sql, parameterized_query)
      assert_equal(parameterized.params, params)
    end

    def test_where
      assert_parameterized_equal TestEmployee.where(:id => 1).to_sql,
        'select "TEST_EMPLOYEES".* from "TEST_EMPLOYEES" where "TEST_EMPLOYEES"."ID" = :a0',
        {'a0' => OracleSqlParser::Ast::NumberLiteral[:value=>"1"]}
    end

    def test_limit
      assert_parameterized_equal TestEmployee.limit(10).to_sql,
        'select "TEST_EMPLOYEES".* from "TEST_EMPLOYEES" where ROWNUM <= :a0',
        {'a0' =>  OracleSqlParser::Ast::NumberLiteral[:value=>"10"]}
    end

#    def test_join
#      puts TestEmployee.join(:model2).to_sql
#    end
#
#    def test_include
#      puts TestEmployee.includes(:model2).to_sql
#    end

  end
end
