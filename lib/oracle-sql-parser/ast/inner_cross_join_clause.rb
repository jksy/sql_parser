module OracleSqlParser::Ast
  class InnerCrossJoinClause < Hash
    def table1=(value)
      @ast[:table1] = value
    end
  end
end
