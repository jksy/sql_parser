module OracleSqlParser::Ast
  class SearchedCaseExpression < Base

    def else_clause=(ast)
      @ast[:else_clause] = ast
    end
  end
end
