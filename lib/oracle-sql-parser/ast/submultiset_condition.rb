# frozen_string_literal: true

module OracleSqlParser::Ast
  class SubmultisetCondition < Hash
    def to_sql(_options = {})
      @ast.values_at(:target, :not, :submultiset, :of, :table).compact.map(&:to_sql).join(' ')
    end
  end
end
