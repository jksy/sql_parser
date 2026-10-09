module OracleSqlParser::Ast
  class FunctionExpression < Hash
    def to_sql(options = {})
      sql = []
      sql << @ast[:name].to_sql
      sql << '('
      sql << @ast[:args].map(&:to_sql).join(',') if @ast[:args]
      sql << ')'
      sql.join
    end
  end
end
