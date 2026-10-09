# frozen_string_literal: true

module OracleSqlParser::Ast
  class TimezoneClause < Hash
    def to_sql(_options = {})
      @ast.values_at(:time, :zone, :expr).map(&:to_sql).join(' ')
    end
  end
end
