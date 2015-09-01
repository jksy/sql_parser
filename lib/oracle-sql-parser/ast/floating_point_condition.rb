module OracleSqlParser::Ast
  class FloatingPointCondition < Hash
    def to_sql(options = {})
      @ast.values_at(:target, :is, :not, :value).compact.map(&:to_sql).join(' ')
    end
  end
end
