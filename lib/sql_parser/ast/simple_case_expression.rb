module SqlParser::Ast
  class SimpleCaseExpression < Hash
    def else_clause=(ast)
      @ast[:else_clause] = ast
    end
  end
end
