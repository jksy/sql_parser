class SqlParser::LikeCondition
  attr_reader  :target, :not, :text, :escape

  def initialize(_target, _not, _text, _escape)
    @target, @not, @text, @escape = _text, _not, _text, _escape
  end
end
