module OracleSqlParser::Ast
  class Subquery < Hash
    def to_sql(options = {})
      if @ast[:union]
        [
          @ast[:query_block1],
          @ast[:union].map(&:to_sql).join(' '),
          @ast[:query_block2],
          @ast[:order_by_clause],
        ].compact.map(&:to_sql).join(' ')
      else
        [
          @ast[:query_block],
          @ast[:order_by_clause]
        ].compact.map(&:to_sql).join(' ')
      end
    end

    def order_by_clause=(value)
      @ast[:order_by_clause] = value
    end
  end
end
