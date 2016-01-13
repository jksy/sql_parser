module OracleSqlParser::Ast
  class Identifier < Hash
    def inspect
      "#<#{self.class.name} #{@ast.inspect}>"
    end

    def quoted?
      @ast[:quoted] == true
    end

    def to_sql(options = {})
      result = []
      if quoted?
        result << "\"#{@ast[:name]}\""
      else
        result << @ast[:name]
      end
      result << @ast[:as] if @ast[:as]
      result << @ast[:alias] if @ast[:alias]
      result.map(&:to_sql).join(' ')
    end
  end
end
