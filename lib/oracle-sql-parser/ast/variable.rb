module OracleSqlParser::Ast
  class Variable < Base
    def to_sql
      ":#{@ast[:name]}"
    end
  end
end
