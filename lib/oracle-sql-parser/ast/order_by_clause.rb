module OracleSqlParser::Ast
  class OrderByClause < Hash
    def to_sql
      sql = []
      sql << "order"
      sql << @ast[:siblings].to_sql if @ast[:siblings]
      sql << "by"
      sql << @ast[:items].to_sql(:separator => ',')
      sql.join(" ")
    end
  end
end
