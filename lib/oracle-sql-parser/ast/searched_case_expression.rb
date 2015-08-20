module OracleSqlParser::Ast
  class SearchedCaseExpression < Base
    def else_clause=(ast)
      @ast[:else_clause] = ast
    end

    def to_sql(options = {})
      sql = []
      sql << 'case'
      sql << 'when'
      sql << @ast[:when_condition]
      sql << 'then'
      sql << @ast[:return_expr]
      sql << 'else'
      sql << @ast[:else_clause]
      sql << 'end'
      sql.compact.map(&:to_sql).join(' ')
    end
  end
end
