class SqlParser::RegexpLikeCondition
  attr_reader :target, :regexp

  def initialize(_target, _regexp)
    @target, @regexp = _target, _regexp
  end
end
