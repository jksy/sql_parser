module OracleSqlParser::Ast
  class BetweenCondition < Hash
    def to_sql(options = {})
      [
        @ast[:target],
        @ast[:not],
        "between",
        @ast[:from],
        "and",
        @ast[:to]
      ].map(&:to_sql).compact.join(' ')
    end
  end
end
