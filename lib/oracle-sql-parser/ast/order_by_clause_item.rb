module OracleSqlParser::Ast
  class OrderByClauseItem < Hash
    def to_sql(options = {})
      sql = @ast.values_at(:target, :asc).map(&:to_sql).compact.join(" ")
      @ast[:nulls].until_nil {|v| sql += " nulls #{v.to_sql}"}
      sql
    end
  end
end
