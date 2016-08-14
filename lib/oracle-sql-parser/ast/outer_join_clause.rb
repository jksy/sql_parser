module OracleSqlParser::Ast
  class OuterJoinClause < Hash
    def table1=(value)
      @ast[:table1] = value
    end

    def to_sql(options = {})
      @ast.values_at(:table1, :natural, :join_type, :outer, :join, :table2, :on_or_using_clause).
        compact.map(&:to_sql).join(' ')
    end
  end
end
