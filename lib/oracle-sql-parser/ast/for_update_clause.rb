module OracleSqlParser::Ast
  class ForUpdateClause < Hash
    def to_sql
      sql = []
      sql << "for update"
      sql << "of #{@ast[:columns].to_sql(:separator => ',')}" if @ast[:columns]
      sql << @ast.values_at(:wait, :time).map(&:to_sql).compact.join(" ") if @ast[:wait]
      sql.join(" ")
    end
  end
end
