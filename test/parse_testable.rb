module ParseTestable
  Ast = OracleSqlParser::Ast
  def parser
    parser ||= OracleSqlParser::Grammar::GrammarParser.new
  end

  def generate_ast(query)
    result = parser.parse query
    if result.nil?
      message = "\n#{query}\n" + " " * ([parser.failure_column.to_i-1, 0].max) + "*\n"
      begin
        message = parser.failure_reason + message
      rescue NoMethodError => e
        # ignore NoMethodError: undefined method `empty?
        #  on gems/treetop-1.6.10/lib/treetop/runtime/compiled_parser.rb:55:in `terminal_failures'
        puts e
        nil
      end

      raise message
    end
    ast = result.ast
    ast.remove_nil_values!
    ast
  end

  def parse_successful(query)
    generate_ast(query)
  end

  def assert_ast_sql_equal(query, expect_ast)
    actual_ast = generate_ast(query)
    assert_ast_equal(expect_ast, actual_ast)
    assert_sql_equal(expect_ast, query)
  end

  def assert_sql_equal(ast, query)
    assert_equal(ast.to_sql, query)
  end

  def enable_debug
    indent = 0
    method_names = OracleSqlParser::Grammar::GrammarParser.instance_methods.grep(/_nt_.*/)
    method_names.each do |name|
      OracleSqlParser::Grammar::GrammarParser.send(:define_method, "#{name}_new") do
        truncate_length = 40
        indent = indent + 1
        head = if index != 0
                 input[0..index-1]
               else
                 ''
               end
        tail = input.gsub(head, '')
        if head.length >= truncate_length
          head = '...' + head[truncate_length-3..-1]
        end
        if tail.length >= truncate_length
          tail = tail[0..truncate_length-1] + '...'
        end
        parsing_text = "#{head}#{'*'.green}#{tail}"
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
