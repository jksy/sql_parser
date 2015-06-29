module SqlParser
  class TextLiteral
    attr_reader :value
    def initialize(_value)
      @value = _value
    end

    def to_s
      value
    end
  end
end
