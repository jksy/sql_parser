module Treetop::Runtime
  class SyntaxNode
    def ast
      return nil if (elements.nil? || elements.empty?) && text_value == ''

      OracleSqlParser::Ast::Base.new(text_value)
    end
  end
end
