# frozen_string_literal: true

module OracleSqlParser::Ast
  class ExistsCondition < Hash
    def to_sql(_options = {})
      "exists (#{@ast[:target].to_sql})"
    end
  end
end
