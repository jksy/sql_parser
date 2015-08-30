module OracleSqlParser::Ast
  class InnerJoinClause < InnerCrossJoinClause
    def to_sql
      @ast.values_at(:table1, :inner, :join, :table2, :on_or_using_clause).
           map(&:to_sql).compact.join(' ')
    end
  end
end
