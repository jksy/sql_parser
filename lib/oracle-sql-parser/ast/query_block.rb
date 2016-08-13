module OracleSqlParser::Ast
  class QueryBlock < Hash
    def to_sql(options = {})
      [
        "select",
        @ast[:hint],
        @ast[:modifier],
        @ast[:select_list].map(&:to_sql).join(','),
        "from",
        @ast[:select_sources].map(&:to_sql).join(','),
        @ast[:where_clause],
        @ast[:group_by_clause],
        @ast[:model_clause]
      ].compact.map(&:to_sql).join(" ")
    end
  end
end
