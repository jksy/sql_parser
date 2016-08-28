module OracleSqlParser::Ast
  class IntervalExpression < Hash
    def to_sql(options = {})
      result = []
      result << '('
      result << @ast[:left]
      result << '-'
      result << @ast[:right]
      result << ')'
      result << (@ast[:day] || @ast[:year])
      if @ast[:leading_field_precision]
        result << '('
        result << @ast[:leading_field_precision]
        result << ')'
      end
      result << @ast[:to]
      result << (@ast[:second] || @ast[:month])
      if @ast[:fractional_second_precision]
        result << '('
        result << @ast[:fractional_second_precision]
        result << ')'
      end
      result.compact.map(&:to_sql).join(' ')
    end
  end
end

