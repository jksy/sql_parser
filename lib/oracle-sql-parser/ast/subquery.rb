module OracleSqlParser::Ast
  class Subquery < Hash
    def to_sql(options = {})
      result = @ast.values_at(
        :query_block,
        :subqueries,
        :subquery,
        :order_by_clause,
        :row_limiting_clause,
      ).map(&:to_sql)

      if @ast[:has_parenthesis]
        result.unshift('(')
        result.push(')')
      end
      result.compact.map(&:to_sql).join(' ')
    end
  end
end
