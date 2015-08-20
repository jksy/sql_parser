module OracleSqlParser::Ast
  class NullCondition < Hash
    def to_sql(options = {})
      [
        @ast[:target],
        "is",
        @ast[:not],
        "null"
      ].compact.map(&:to_sql).join(' ')
    end
  end
end
