module OracleSqlParser::Ast
  class SimpleCaseExpression < Hash
    def else_clause=(ast)
      @ast[:else_clause] = ast
    end

    def to_sql(options = {})
      sql = []
      sql << 'case'
      sql << @ast[:condition]
      sql << @ast[:when_clauses].map{|v| "when #{v.when_expr.to_sql} then #{v.return_expr.to_sql}"}.join(' ')
      if @ast[:else_clause]
        sql << 'else'
        sql << @ast[:else_clause]
      end
      sql << 'end'
      sql.compact.map(&:to_sql).join(' ')
    end
  end
end
