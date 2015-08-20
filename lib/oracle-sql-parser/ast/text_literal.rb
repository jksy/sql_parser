module OracleSqlParser::Ast
  class TextLiteral < Hash
    def inspect
      "#<#{self.class.name} #{@ast.inspect}>"
    end

    def to_sql(options = {})
      "'#{@ast[:value]}'"
    end
  end
end
