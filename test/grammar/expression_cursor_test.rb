require File.expand_path('base_test.rb', File.dirname(__FILE__))

module Grammar
  class ExpressionCaseTest < BaseTest
    def test_cursor_expression
      assert_ast_sql_equal "select cursor(select salary from employees e where e.department_id = d.department_id) from departments d",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SelectColumn[
                  :expr => Ast::CursorExpression[
                    :cursor => Ast::Keyword[:name => 'cursor'],
                    :subquery => generate_ast('select salary from employees e where e.department_id = d.department_id').subquery,
                  ]
                ]
              ],
              :select_sources => Ast::Array[
                Ast::TableReference[
                  :table_name => Ast::Identifier[:name => 'departments'],
                  :table_alias=> Ast::Identifier[:name => 'd'],
                ]
              ]
            ]
          ]
        ]
    end
  end
end
