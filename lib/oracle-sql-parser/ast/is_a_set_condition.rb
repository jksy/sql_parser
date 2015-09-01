module OracleSqlParser::Ast
  class IsASetCondition < Hash
    def to_sql(options = {})
      @ast.values_at(:target, :is, :not, :a, :set).compact.map(&:to_sql).join(' ')
    end
  end
end
