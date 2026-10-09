# frozen_string_literal: true

module OracleSqlParser::Ast
  class WhereClause < Hash
    def to_sql(_options = {})
      "where #{@ast[:condition].to_sql}"
    end
  end
end
