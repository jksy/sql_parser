module OracleSqlParser::Ast
  class OnClause < Hash
    def to_sql
      @ast.values_at(:on, :condition).map(&:to_sql).join(' ')
    end
  end
end
