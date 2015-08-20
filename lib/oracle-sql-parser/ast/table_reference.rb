module OracleSqlParser::Ast
  class TableReference < Hash
    
    def inspect
      "#<#{self.class.name} #{@ast.inspect}>"
    end

    def to_sql(options = {})
      result = @ast[:schema_name].to_sql.to_s + @ast[:table_name].to_sql
      if @ast[:dblink]
        result += "@#{@ast[:dblink].to_sql}"
      end
      result
    end
  end
end
