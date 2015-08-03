module OracleSqlParser::Ast
  class Identifier < Hash
    def inspect
      "#<#{self.class.name} #{@ast.inspect}>"
    end
  end
end
