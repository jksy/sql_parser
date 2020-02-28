module OracleSqlParser::Ast
  class RowLimitingClause < Hash
    def to_sql(options = {})
      @ast.values_at(
        :offset,
        :fetch,
      ).compact.map(&:to_sql).join(' ')
    end
  end
end
