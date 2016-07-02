module OracleSqlParser::Ast
  class TableReference < Hash

    def inspect
      "#<#{self.class.name} #{@ast.inspect}>"
    end

    def to_sql(options = {})
      result = ''
      result += "#{@ast[:schema_name].to_sql}." if @ast[:schema_name]
      result += @ast[:table_name].to_sql
      result += "@#{@ast[:dblink].to_sql}" if @ast[:dblink]
      result += " #{@ast[:table_alias].to_sql}" if @ast[:table_alias]
      result
    end
  end
end
