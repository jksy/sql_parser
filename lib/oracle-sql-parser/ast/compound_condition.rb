module OracleSqlParser::Ast
  class CompoundCondition < Base
    def to_sql(options = {})
      "(#{@ast.to_sql})"
    end
  end
end
