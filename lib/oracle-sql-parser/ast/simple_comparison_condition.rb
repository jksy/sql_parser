# frozen_string_literal: true

module OracleSqlParser::Ast
  class SimpleComparisonCondition < Hash
    def to_sql(_options = {})
      @ast.values_at(:left, :op, :right).map(&:to_sql).join(' ')
    end
  end
end
