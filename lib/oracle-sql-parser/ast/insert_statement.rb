module OracleSqlParser::Ast
  class InsertStatement < Hash
    def to_sql
      result = []
      result << "insert into"
      result << @ast[:insert]
      result << "(#{@ast[:columns].map(&:to_sql).join(',')})" if @ast[:columns]
      result << @ast[:values]
      result.compact.map(&:to_sql).join(' ')
    end
  end
end
