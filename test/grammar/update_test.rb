require File.expand_path('base_test.rb', File.dirname(__FILE__))

module Grammar
  class UpdateTest < BaseTest
    def test_update_parseable
      assert_ast_sql_equal "update table1 set col1 = 1",
        Ast::UpdateStatement[
          :target => Ast::TableReference[
            :table_name => Ast::Identifier[:name => 'table1']
          ],
          :set => Ast::UpdateSetClause[
              Ast::UpdateSetColumn[:column_name => Ast::Identifier[:name => 'col1'],
                                   :op => '=',
                                   :value => Ast::NumberLiteral[:value => '1']]
          ]
        ]
    end

    def test_update_plural_column_parseable
      assert_ast_sql_equal "update table1 set col1 = 1,col2 = 2",
        Ast::UpdateStatement[
          :target => Ast::TableReference[
            :table_name => Ast::Identifier[:name => 'table1']
          ],
          :set => Ast::UpdateSetClause[
              Ast::UpdateSetColumn[:column_name => Ast::Identifier[:name => 'col1'],
                                   :op => '=',
                                   :value => Ast::NumberLiteral[:value => '1']],
              Ast::UpdateSetColumn[:column_name => Ast::Identifier[:name => 'col2'],
                                   :op => '=',
                                   :value => Ast::NumberLiteral[:value => '2']]
          ]
        ]
    end

    def test_update_condition_parseable
      ast = generate_ast("update table1 set col1 = 1")
      assert_ast_sql_equal "update table1 set col1 = 1 where col2 = 1",
        Ast::UpdateStatement[
          :target => ast.target,
          :set => ast.set,
          :where_clause => Ast::WhereClause[
            :condition => Ast::SimpleComparisionCondition[
              :left => Ast::Identifier[:name => 'col2'],
              :op => '=',
              :right => Ast::NumberLiteral[:value => '1']
            ]
          ]
        ]
    end

    def test_update_current_of_condition_parseable
      ast = generate_ast("update table1 set col1 = 1")
      assert_ast_sql_equal "update table1 set col1 = 1 where current_of cursor_name",
        Ast::UpdateStatement[
          :target => ast.target,
          :set => ast.set,
          :where_clause => Ast::WhereClause[
            :condition => Ast::CurrentOf[
              :cursor => Ast::Identifier[:name => 'cursor_name']
            ]
          ]
        ]
    end
  end
end
