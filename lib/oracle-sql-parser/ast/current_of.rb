module OracleSqlParser::Ast
  class CurrentOf < Hash
    def to_sql
      "current_of #{@ast[:name].to_sql}"
    end
  end
end
