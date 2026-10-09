# frozen_string_literal: true

module OracleSqlParser::Ast
  class SelectStatement < Hash
    def to_sql(_options = {})
      @ast.values_at(:subquery, :for_update_clause).compact.map(&:to_sql).join(' ')
    end
  end
end
