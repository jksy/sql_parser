module OracleSqlParser::Ast
  class UsingClause < Hash
    def to_sql
      result = []
      result << @ast[:using]
      result << "(#{@ast[:column_list].map(&:to_sql).join(',')})"
      result.map(&:to_sql).join(' ')
    end
  end
end
