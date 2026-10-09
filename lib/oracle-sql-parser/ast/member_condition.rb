# frozen_string_literal: true

module OracleSqlParser::Ast
  class MemberCondition < Hash
    def to_sql(_options = {})
      @ast.values_at(:target, :is, :not, :member, :of, :table)
          .compact.map(&:to_sql).join(' ')
    end
  end
end
