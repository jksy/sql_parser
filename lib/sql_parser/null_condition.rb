module SqlParser
  class NullCondition
    attr_reader :target, :null

    def initialize(_target, _null)
      @target, @null = _target, _null
    end
  end
end
