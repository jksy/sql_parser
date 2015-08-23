module OracleSqlParser::Ast
  class DeleteTarget < Hash
    def to_sql
      result = []
      result << @ast[:table] if @ast[:table]
      if @ast[:name].instance_of? Subquery
        result << "(#{@ast[:name].to_sql})"
      else
        result << @ast[:name]
      end
      result << @ast[:alias] if @ast[:alias]
      result.map(&:to_sql).join(" ")
    end
  end
end

