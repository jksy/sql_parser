module SqlParser::Ast
  class SimpleCaseExpression < Base
    def else_clause=(ast)
      @ast[:else_clause] = ast
    end
  end
end
