module OracleSqlParser::Ast
  class InsertValuesClause < Array
    def to_sql
      "values(#{@ast.map(&:to_sql).join(',')})"
    end
  end
end
