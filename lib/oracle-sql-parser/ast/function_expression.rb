module OracleSqlParser::Ast
  class FunctionExpressoin < Hash
    def to_sql(options = {})
      sql = []
      sql << @ast[:name].to_sql
      sql << '('
      if @ast[:args]
        sql << @ast[:args].map(&:to_sql).join(',')
      end
      sql << ')'
      sql.join()
    end
  end
end
