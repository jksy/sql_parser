module OracleSqlParser::Ast
  class DeleteStatement < Hash
    def to_sql
      sql = []
      sql << "delete"
      sql << "from"
      sql << @ast[:target]
      sql << @ast[:where_clause] if @ast[:where_clause]
      sql.map(&:to_sql).join(' ')
    end
  end
end
