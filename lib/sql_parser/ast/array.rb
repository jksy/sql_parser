module SqlParser::Ast
  class Array < Base
    def initialize(*args)
      @ast = args
    end
  end
end
