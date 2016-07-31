module OracleSqlParser::Ast
  class CompoundExpression < Hash
    def to_sql(options = {})
      @ast.values_at(:left_parenthesis,
                     :left,
                     :op,
                     :right,
                     :right_parenthesis).map(&:to_sql).join
    end
  end
end
