module OracleSqlParser::Ast
  class TimezoneClause < Hash
    def to_sql(options = {})
      @ast.values_at(:time, :zone, :expr).map(&:to_sql).join(' ')
    end
  end
end

