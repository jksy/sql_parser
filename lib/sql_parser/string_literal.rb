module SqlParser
  class StringLiteral
    attr_reader :value
  end

  def initialize(_value)
    @value = _value
  end

  def to_s
    value
  end
end
