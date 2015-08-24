module OracleSqlParser::Ast
  class UpdateSetColumn < Hash
    def to_sql
      @ast.values_at(:column_name, :op, :value).map(&:to_sql).join(' ')
    end
  end
end
