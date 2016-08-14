module OracleSqlParser::Ast
  class CrossNaturalJoinClause < InnerCrossJoinClause
    def to_sql(options = {})
      @ast.values_at(:table1, :cross, :natural, :inner, :join, :table2).
        compact.map(&:to_sql).join(' ')
    end
  end
end
