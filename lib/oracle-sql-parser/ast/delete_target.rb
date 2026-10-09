# frozen_string_literal: true

module OracleSqlParser::Ast
  class DeleteTarget < Hash
    def to_sql
      result = []
      result << @ast[:table] if @ast[:table]
      result << if @ast[:name].instance_of? Subquery
                  "(#{@ast[:name].to_sql})"
                else
                  @ast[:name]
                end
      result << @ast[:alias] if @ast[:alias]
      result.map(&:to_sql).join(' ')
    end
  end
end
