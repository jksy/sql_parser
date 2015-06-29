module SqlParser
  class Where
    attr_reader :conditions

    def initialize(conditions)
      @conditions = Array(conditions)
    end

    def to_s
      "#{self.class.to_s} #{conditions.join(' ')}"
    end
  end
end
