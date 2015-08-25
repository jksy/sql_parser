module OracleSqlParser::Ast
  class OrderByClauseItem < Hash
    def to_sql(options = {})
      sql = @ast.values_at(:target, :asc).map(&:to_sql).compact.join(" ")
      sql += " nulls #{@ast[:nulls].to_sql}" if @ast[:nulls]
      sql
    end
  end
end
