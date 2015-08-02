module SqlParser::Ast
  class Identifier < Hash
    def inspect
      "#<#{self.class.name} #{@ast.inspect}>"
    end
  end
end
