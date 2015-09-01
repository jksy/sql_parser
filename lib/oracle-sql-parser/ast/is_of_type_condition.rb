module OracleSqlParser::Ast
  class IsOfTypeCondition < Hash
    def to_sql(options = {})
      [
        @ast[:target],
        @ast[:is],
        @ast[:not],
        @ast[:of],
        @ast[:type],
        "(#{@ast[:types].map(&:to_sql).join(',')})",
      ].compact.map(&:to_sql).join(' ')
    end
  end
end
