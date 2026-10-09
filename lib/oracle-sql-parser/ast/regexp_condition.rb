# frozen_string_literal: true

module OracleSqlParser::Ast
  class RegexpCondition < Hash
    def to_sql(_options = {})
      "regexp_like(#{@ast[:target].to_sql},#{@ast[:regexp].to_sql})"
    end
  end
end
