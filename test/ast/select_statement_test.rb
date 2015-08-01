require File.expand_path('../test_helper.rb', File.dirname(__FILE__))

module Ast
  class SelectStatementTest < Test::Unit::TestCase
    def test_to_sql
      assert_equal(
       Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::QueryBlock[
            :select_list => Ast::Array[
              Ast::Identifier[:name => 'col1']
            ],
            :select_sources => Ast::Identifier[:name => 'table1']
          ],
        ],
      ].to_sql ,
      "select col1 from table1")
    end
  end
end

