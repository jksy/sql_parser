module SqlParser::Ast
  class TextLiteral
    attr_reader :value
    def initialize(value)
      @value = value
    end

    def inspect
      "#<#{self.class.name} value=#{value}>"
    end
  end
end
