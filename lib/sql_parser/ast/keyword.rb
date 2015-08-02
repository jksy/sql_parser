module SqlParser::Ast
  class Keyword < Hash
    def inspect
      "<##{self.class.name} #{@ast.inspect}>"
    end
  end
end

