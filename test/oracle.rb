require File.expand_path('test_helper.rb', File.dirname(__FILE__))
require 'sql_parser'

class OracleTest < Test::Unit::TestCase
  def setup
  end

  def teardown
  end

  def test_select
    parsed = parser.parse 'select col1 from table1'
    puts parsed
  end

  def parser
    unless @parser
      @parser = SqlParser::Oracle.new
      @parser.yydebug = false
    end
    @parser
  end
end
