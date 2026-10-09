# frozen_string_literal: true

module OracleSqlParser::Ast
  class RollupCubeClause < Hash
    def to_sql(_options = {})
      "#{@ast[:func_name].to_sql}(#{@ast[:args].to_sql(separator: ',')})"
    end
  end
end
