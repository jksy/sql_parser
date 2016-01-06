require File.expand_path('base_test.rb', File.dirname(__FILE__))

module OracleEnhancedAdapter
  class SelectTest < BaseTest

    def self.startup
      ActiveRecord::Base.establish_connection(BaseTest.connection_params)
      BaseTest.create_test_table
    end

    def setup
      # for ruby 1.9.3
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
      assert_parameterized_equal(TestEmployee.where(:id => 1).to_sql,
        'select "TEST_EMPLOYEES".* from "TEST_EMPLOYEES" where "TEST_EMPLOYEES"."ID" = :a0',
        {'a0' => OracleSqlParser::Ast::NumberLiteral[:value => "1"]}
      )
    end

    def test_where_and
      assert_parameterized_equal(TestEmployee.where(:id => 1, :name => 'asdf').to_sql,
        'select "TEST_EMPLOYEES".* from "TEST_EMPLOYEES" where "TEST_EMPLOYEES"."ID" = :a0 AND "TEST_EMPLOYEES"."NAME" = :a1',
        {'a0' => OracleSqlParser::Ast::NumberLiteral[:value => "1"],
         'a1' => OracleSqlParser::Ast::TextLiteral[:value => 'asdf']}
      )
    end

    def test_where_between
      assert_parameterized_equal(TestEmployee.where(:age => 1..10).to_sql,
        'select "TEST_EMPLOYEES".* from "TEST_EMPLOYEES" where ("TEST_EMPLOYEES"."AGE" between :a0 and :a1)',
        {'a0' => OracleSqlParser::Ast::NumberLiteral[:value => '1'],
         'a1' => OracleSqlParser::Ast::NumberLiteral[:value => '10']}
      )
    end

    def test_limit
      assert_parameterized_equal(TestEmployee.limit(10).to_sql,
        'select "TEST_EMPLOYEES".* from "TEST_EMPLOYEES" where ROWNUM <= :a0',
        {'a0' =>  OracleSqlParser::Ast::NumberLiteral[:value => '10']}
      )
    end

    def test_joins
      assert_parameterized_equal(TestEmployee.joins(:company).where(:id => 1).to_sql,
        'select "TEST_EMPLOYEES".* from "TEST_EMPLOYEES" INNER JOIN "TEST_COMPANIES" ON "TEST_COMPANIES"."TEST_EMPLOYEE_ID" = "TEST_EMPLOYEES"."ID" where "TEST_EMPLOYEES"."ID" = :a0',
        {'a0' =>  OracleSqlParser::Ast::NumberLiteral[:value => '1']}
      )
    end

    def test_includes
      omit("still do not support 'select column_name as alias_name from..'")
      query = TestEmployee.includes(:company).where(:test_employee => {:id => 1}).to_sql
      assert_parameterized_equal(query,
        'select "TEST_EMPLOYEES".* from "TEST_EMPLOYEES" INNER JOIN "TEST_COMPANIES" ON "TEST_COMPANIES"."TEST_EMPLOYEE_ID" = "TEST_EMPLOYEES"."ID" where "TEST_EMPLOYEES"."ID" = :a0',
        {'a0' =>  OracleSqlParser::Ast::NumberLiteral[:value => '1']}
      )
    end
  end
end
