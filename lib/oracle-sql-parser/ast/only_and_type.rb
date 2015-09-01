module OracleSqlParser::Ast
  class OnlyAndType < Hash
    def to_sql(options ={})
      @ast.values_at(:only, :type).compact.map(&:to_sql).join(' ')
    end
  end
end
