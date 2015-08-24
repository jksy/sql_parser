module OracleSqlParser::Ast
  class UpdateStatement < Hash
    def to_sql
      result = []
      result << "update"
      result << @ast[:target]
      result << @ast[:set]
      result << @ast[:where_clause]
      result.compact.map(&:to_sql).join(' ')
    end
  end
end
