module OracleSqlParser::Ast
  class DatetimeExpression < Hash
    def to_sql(options = {})
      @ast.values_at(:expr, :at, :local, :timezone).compact.map(&:to_sql).join(' ')
    end
  end
end

