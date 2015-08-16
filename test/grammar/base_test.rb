require File.expand_path('../test_helper.rb', File.dirname(__FILE__))

module Grammar
  class BaseTest < Test::Unit::TestCase
    Ast = OracleSqlParser::Ast
    def parser
      parser ||= OracleSqlParser::Grammar::GrammarParser.new
    end
  
    def generate_ast(query)
      result = parser.parse query
      if result.nil?
        message = "\n#{query}\n" + " " * (parser.failure_column.to_i-1) + "*\n"
        raise parser.failure_reason + message
      end
      result.ast
    end
  
    def parse_successful(query)
      generate_ast(query)
    end
  
    def assert_ast_sql_eual(query, expect_ast)
      actual_ast = generate_ast(query)
      actual_ast.remove_nil_values!
      assert_ast_equal(expect_ast, actual_ast)
      assert_sql_equal(expect_ast, query)
    end

    # obsolete, replace to assert_ast_sql_eual
    def same_ast?(query, expect)
      actual = generate_ast(query)
      expect.remove_nil_values!
      actual.remove_nil_values!
      assert_ast_equal(expect, actual)
    end

    def assert_sql_equal(ast, query)
      assert_equal(ast.to_sql, query)
    end
  
    def enable_debug
      indent = 0
      method_names = OracleSqlParser::Grammar::GrammarParser.instance_methods.grep(/_nt_.*/)
      method_names.each do |name|
        OracleSqlParser::Grammar::GrammarParser.send(:define_method, "#{name}_new") do
          indent = indent + 1
          if index != 0
            parsing_text = "#{input[0..index-1]}*#{input[index..-1]}"
          else
            parsing_text = "*#{input}"
          end
          puts(" " * indent + name.to_s + ":#{index}" + ": \t\t#{parsing_text}")
          result = send("#{name}_old")
          indent = indent - 1
          result
        end
        OracleSqlParser::Grammar::GrammarParser.class_eval do
          alias_method "#{name}_old", "#{name}"
          alias_method "#{name}", "#{name}_new"
        end
      end
    end
  end
end
