module OracleSqlParser::Util
  module Parameterizable
    def to_parameternized
      Kernel.warn "to_parameternized is deprecated and will be removed. use to_parameterized"
      to_parameterized
    end

    def to_parameterized
      ParameternizedQuery.new(self)
    end
  end
end
