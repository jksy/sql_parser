module OracleSqlParser::Ast
  class LikeCondition < Hash
    def to_sql(options = {})
      sql = [
        @ast[:target],
        @ast[:not],
        @ast[:like],
        @ast[:text],
      ]
      if @ast[:escape]
        sql << "escape"
        sql << @ast[:escape]
      end
      sql.map(&:to_sql).compact.join(' ')
    end
  end
end
