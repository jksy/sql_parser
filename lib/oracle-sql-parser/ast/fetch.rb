# frozen_string_literal: true

module OracleSqlParser::Ast
  class Fetch < Hash
    def to_sql(_options = {})
      @ast.values_at(
        :fetch, :first,
        :rowcount, :percentage, :percentage_keyword,
        :rows, :only, :with, :ties
      ).compact.map(&:to_sql).join(' ')
    end
  end
end
