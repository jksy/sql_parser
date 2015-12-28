module OracleSqlParser::Ast
  class NumberLiteral < Hash
    def inspect
      "#<#{self.class.name} #{@ast.inspect}>"
    end

    def to_decimal
      BigDecimal.new(@ast[:value])
    end
  end
end

