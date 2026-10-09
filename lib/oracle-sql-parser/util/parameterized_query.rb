# frozen_string_literal: true

module OracleSqlParser::Util
  # A copy of an AST whose number and text literals are replaced with bind
  # variables (:a0, :a1, ...), along with the replaced values in params.
  class ParameternizedQuery
    attr_reader :ast, :params

    def initialize(original)
      @index = 0
      @params = {}
      @ast = original.map_ast do |v|
        case v
        when OracleSqlParser::Ast::NumberLiteral, OracleSqlParser::Ast::TextLiteral
          assign_parameter(v)
        else
          v
        end
      end
    end

    def to_sql
      ast.to_sql
    end

    def assign_parameter(value)
      name = "a#{@index}"
      @index += 1
      @params[name] = value
      OracleSqlParser::Ast::Variable[name: name]
    end
  end
end
