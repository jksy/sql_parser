module OracleSqlParser::Ast
  class SelectStatement < Hash
    def to_sql(options = {})
      @ast.values_at(:subquery, :for_update_clause).compact.map(&:to_sql).join(' ')
    end
  end
end
