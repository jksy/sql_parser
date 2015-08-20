module OracleSqlParser::Ast
  class RegexpCondition < Hash
    def to_sql(options = {})
      "regexp_like(#{@ast[:target].to_sql},#{@ast[:regexp].to_sql})"
    end
  end
end
