module OracleSqlParser::Ast
  class SelectStatement < Hash
    def to_sql
      sql = @ast[:subquery].to_sql
      sql += " #{@ast[:for_update_clause].to_sql}" if @ast[:for_update_clause]
      sql
    end
  end
end
