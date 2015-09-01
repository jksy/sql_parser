module OracleSqlParser::Ast
  class SubmultisetCondition < Hash
    def to_sql(options = {})
      @ast.values_at(:target, :not, :submultiset,:of, :table).compact.map(&:to_sql).join(' ')
    end
  end
end

