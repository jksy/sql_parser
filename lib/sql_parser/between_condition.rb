module SqlParser
  class BetweenCondition
    attr_reader :target, :not, :first, :last

    def initialize(_target, _not, _first, _last)
      @target, @not, @first, @last = _target, _not, _first, _last
    end
  end
end

