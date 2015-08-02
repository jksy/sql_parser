module SqlParser::Ast
  class NumberLiteral < Hash
    def inspect
      "#<#{self.class.name} #{@ast.inspect}>"
    end
  end
end

