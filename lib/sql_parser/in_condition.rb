class SqlParser::InCondition
  attr_reader :target, :not, :value

  def initialize(_target, _not, _value)
    @target, @not, @value = _target, _not, _value
  end
end
