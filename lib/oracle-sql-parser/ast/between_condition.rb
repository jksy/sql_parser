# frozen_string_literal: true

module OracleSqlParser::Ast
  class BetweenCondition < Hash
    def to_sql(_options = {})
      [
        @ast[:target],
        @ast[:not],
        'between',
        @ast[:from],
        'and',
        @ast[:to]
      ].map(&:to_sql).compact.join(' ')
    end
  end
end
