module OracleSqlParser::Ast
  class CompoundExpression < Hash
    def to_sql(options = {})
      r = @ast.values_at(:left,
                         :op,
                         :right,
                        ).map(&:to_sql)
      if @ast[:has_parenthesis]
        r.unshift('(')
        r.push(')')
      end
      r.compact.join(' ')
    end
  end
end
