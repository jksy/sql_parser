module SqlParser
  class SelectTable < SyntaxNodeBase
    attr_reader :table
    def initialize(input, interval, elements = nil)
      super
      @table = elements.first
    end
    
    def elements
      [@table]
    end

  end
end

