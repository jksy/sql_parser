# frozen_string_literal: true

module OracleSqlParser::Ast
  class SelectColumn < Hash
    def to_sql(_options = {})
      @ast.values_at(:expr, :as, :c_alias).compact.map(&:to_sql).join(' ')
    end
  end
end
