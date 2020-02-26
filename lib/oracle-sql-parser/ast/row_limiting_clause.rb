module OracleSqlParser::Ast
  class RowLimitingClause < Hash
    def to_sql(options = {})
      @ast.values_at(
        :offset_keyword, :offset,
        :row_keyword, :rows_keyword,
        :fetch_keyword, :first_keyword,
        :next_keyword, :rowcount,
        :percentage, :percentage_keyword,
        :row_keyword, :rows_keyword, :only_keyword, :with_keyword, :ties_keyword
      ).compact.map(&:to_sql).join(' ')
    end
  end
end
