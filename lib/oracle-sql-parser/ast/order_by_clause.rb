module OracleSqlParser::Ast
  class OrderByClause < Hash
    def to_sql
      sql = []
      sql << "order"
      @ast[:siblings].until_nil {|v| sql << v.to_sql}
      sql << "by"
      sql << @ast[:items].to_sql(:separator => ',')
      sql.join(" ")
    end
  end
end
