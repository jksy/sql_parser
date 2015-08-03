module OracleSqlParser::Ast
  class QueryBlock < Hash
    def to_sql
      [
        "select",
        @ast[:hint],
        @ast[:modifier],
        @ast[:select_list],
        "from",
        @ast[:select_sources],
        @ast[:where_clause],
        @ast[:group_by_clause],
        @ast[:model_clause]
      ].compact.map(&:to_sql).join(" ")
    end
  end
end
