module OracleSqlParser::Ast
  class SimpleComparisionCondition < Hash
    def to_sql
      @ast.values_at(:left, :op, :right).map(&:to_sql).join(' ')
    end
  end
end
