module OracleSqlParser::Ast
  class RollupCubeClause < Hash
    def to_sql(options = {})
      "#{@ast[:func_name].to_sql}(#{@ast[:args].to_sql(:separator => ',')})"
    end
  end
end
