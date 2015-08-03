module Treetop::Runtime
  class SyntaxNode
    def ast
      if((elements == nil || elements.empty?) && text_value == "")
        return nil
      end
      OracleSqlParser::Ast::Base.new(text_value)
    end
  end
end

