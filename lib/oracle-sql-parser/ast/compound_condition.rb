# frozen_string_literal: true

module OracleSqlParser::Ast
  class CompoundCondition < Hash
    def to_sql(_options = {})
      "(#{@ast[:condition].to_sql})"
    end
  end
end
