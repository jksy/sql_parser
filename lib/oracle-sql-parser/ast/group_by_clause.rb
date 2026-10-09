module OracleSqlParser::Ast
  class GroupByClause < Hash
    def to_sql(options = {})
      result = "group by #{@ast[:targets].to_sql(separator: ',')}"
      result += " having #{@ast[:having].to_sql}" if @ast[:having]
      result
    end
  end
end
