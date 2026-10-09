# frozen_string_literal: true

module Treetop::Runtime
  # Fallback for rules without their own ast method: a plain text node.
  class SyntaxNode
    def ast
      return nil if (elements.nil? || elements.empty?) && text_value == ''

      OracleSqlParser::Ast::Base.new(text_value)
    end
  end
end
