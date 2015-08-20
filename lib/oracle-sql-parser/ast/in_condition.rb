module OracleSqlParser::Ast
  class InCondition < Hash
    def to_sql(options = {})
      [
        @ast[:target],
        @ast[:not],
        "in",
        "(#{@ast[:values].to_sql(:separator => ",")})"
      ].map(&:to_sql).compact.join(' ')
    end
  end
end
