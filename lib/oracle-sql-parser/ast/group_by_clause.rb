module OracleSqlParser::Ast
  class GroupByClause < Hash

    def to_sql
      result = "group by #{@ast[:targets].to_sql(:separator => ',')}"
      if @ast[:having]
        result += " having #{@ast[:having].to_sql}"
      end
      result
    end
  end
end
