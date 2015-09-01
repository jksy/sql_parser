module OracleSqlParser::Ast
  class MemberCondition < Hash
    def to_sql(options = {})
      @ast.values_at(:target, :is, :not, :member, :of, :table).
            compact.map(&:to_sql).join(' ')
    end
  end
end

