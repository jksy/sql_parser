# frozen_string_literal: true

module OracleSqlParser::Ast
  class IsASetCondition < Hash
    def to_sql(_options = {})
      @ast.values_at(:target, :is, :not, :a, :set).compact.map(&:to_sql).join(' ')
    end
  end
end
