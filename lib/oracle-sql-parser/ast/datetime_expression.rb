# frozen_string_literal: true

module OracleSqlParser::Ast
  class DatetimeExpression < Hash
    def to_sql(_options = {})
      @ast.values_at(:expr, :at, :local, :timezone).compact.map(&:to_sql).join(' ')
    end
  end
end
