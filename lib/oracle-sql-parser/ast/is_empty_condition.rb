module OracleSqlParser::Ast
  class IsEmptyCondition < Hash
    def to_sql(options = {})
      @ast.values_at(:target, :is, :not, :empty).compact.map(&:to_sql).join(' ')
    end
  end
end
