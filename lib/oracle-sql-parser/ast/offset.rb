module OracleSqlParser::Ast
  class Offset < Hash
    def to_sql(options = {})
      @ast.values_at(
        :offset_keyword, :offset,
        :row_keyword, :rows_keyword,
      ).compact.map(&:to_sql).join(' ')
    end
  end
end

