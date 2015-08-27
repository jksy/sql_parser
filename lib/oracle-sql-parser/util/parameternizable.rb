module OracleSqlParser::Util
  module Parameternizable
    def to_parameternized
      ParameternizedQuery.new(self)
    end
  end
end
