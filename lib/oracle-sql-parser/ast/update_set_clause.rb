module OracleSqlParser::Ast
  class UpdateSetClause < Array
    def to_sql
      "set #{@ast.map(&:to_sql).join(',')}"
    end
  end
end
