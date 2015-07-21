require File.expand_path('test_helper.rb', File.dirname(__FILE__))

class OracleUpdate < Base
  def test_update_parseable
    same_ast? "update table1 set col1 = 1",
      Ast::UpdateStatement[
        :target => Ast::Identifier[:name => 'table1'],
        :set => Ast::Base[[
            Ast::UpdateSetColumn[:column_name => Ast::Identifier[:name => 'col1'],
                                 :op => '=',
                                 :value => Ast::NumberLiteral[:value => '1']]
        ]]
      ]
  end

  def test_update_plural_column_parseable
    same_ast? "update table1 set col1 = 1, col2 = 2",
      Ast::UpdateStatement[
        :target => Ast::Identifier[:name => 'table1'],
        :set => Ast::Base[
          [
            Ast::UpdateSetColumn[:column_name => Ast::Identifier[:name => 'col1'],
                                 :op => '=',
                                 :value => Ast::NumberLiteral[:value => '1']],
            Ast::UpdateSetColumn[:column_name => Ast::Identifier[:name => 'col2'],
                                 :op => '=',
                                 :value => Ast::NumberLiteral[:value => '2']]
          ]
        ]
      ]
  end

  def test_update_condition_parseable
    ast = generate_ast("update table1 set col1 = 1")
    same_ast? "update table1 set col1 = 1 where col2 = 1",
      Ast::UpdateStatement[
        :target => ast.target,
        :set => ast.set,
        :condition => Ast::WhereClause[
          Ast::SimpleComparisionCondition[
            :left => Ast::Identifier[:name => 'col2'],
            :op => '=',
            :right => Ast::NumberLiteral[:value => '1']
          ]
        ]
      ]
  end

  def test_update_current_of_condition_parseable
    ast = generate_ast("update table1 set col1 = 1")
    same_ast? "update table1 set col1 = 1 where current_of cursor_name",
      Ast::UpdateStatement[
        :target => ast.target,
        :set => ast.set,
        :condition => Ast::WhereClause[
          SqlParser::Ast::CurrentOf[
            :cursor_name => Ast::Identifier[:name => 'cursor_name']
          ]
        ]
      ]
  end

end
