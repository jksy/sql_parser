module OracleSqlParser::Ast
  class CursorExpression < Hash
    def to_sql(options = {})
      [
        @ast[:cursor],
        '(',
        @ast[:subquery],
        ')',
      ].map(&:to_sql).join
    end
  end
end

