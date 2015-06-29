module SqlParser
  class ComparisionCondition < Condition
    attr_reader :left, :operator, :right

    def initialize(left, operator, right)
      @left, @operator, @right = left, operator, right
    end

    def to_s
      "#{left} #{operator} #{right}"
    end
  end
end

