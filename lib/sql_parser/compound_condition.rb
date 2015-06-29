module SqlParser
  class CompoundCondition
    attr_reader :not, :condition

    def initialize(_not, _condition)
      @not, @condition = _not, _condition
    end
  end
end
