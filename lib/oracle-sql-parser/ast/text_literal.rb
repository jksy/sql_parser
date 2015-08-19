module OracleSqlParser::Ast
  class TextLiteral < Hash
    def inspect
      "#<#{self.class.name} #{@ast.inspect}>"
    end

    def to_sql
      "'#{@ast[:value]}'"
    end
  end
end
