module SqlParser::Ast
  class TextLiteral < Hash
    def inspect
      "#<#{self.class.name} #{@ast.inspect}>"
    end
  end
end
