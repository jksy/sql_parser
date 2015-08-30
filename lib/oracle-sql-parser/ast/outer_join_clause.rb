module OracleSqlParser::Ast
  class OuterJoinClause < Hash
    def table1=(value)
      @ast[:table1] = value
    end
  end
end
