module OracleSqlParser::Ast
  class WhereClause < Hash
    def to_sql
      "where #{@ast[:condition].to_sql}"
    end
  end
end
