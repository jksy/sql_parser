module OracleSqlParser::Ast
  class Identifier < Hash
    def inspect
      "#<#{self.class.name} #{@ast.inspect}>"
    end

    def quoted?
      @ast[:quoted] == true
    end

    def to_sql
      if quoted?
        "\"#{@ast[:name]}\""
      else
        @ast[:name]
      end
    end
  end
end
