module OracleSqlParser::Ast
  class CompoundCondition < Hash
    def to_sql(options = {})
      "(#{@ast[:condition].to_sql})"
    end
  end
end
