module SqlParser
  class NumberLiteral
    attr_reader :value

    def initialize(_value)
      @value = _value.to_i
    end

    def to_s
      value.to_s
    end
  end
end

