# frozen_string_literal: true

module OracleSqlParser::Ast
  class RowLimitingClause < Hash
    def to_sql(_options = {})
      @ast.values_at(
        :offset,
        :fetch
      ).compact.map(&:to_sql).join(' ')
    end
  end
end
