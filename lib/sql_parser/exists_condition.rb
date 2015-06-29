class SqlParser::ExistsCondition
  attr_reader :subquery

  def initialize(_subquery)
    @subquery = _subquery
  end
end
