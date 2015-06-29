module SqlParser
  class LogicalCondition < Condition
    attr_reader :left, :op, :right
    
    def initialize(left, op, right)
      @left, @op, @right = left, op, right
    end
  end
end
