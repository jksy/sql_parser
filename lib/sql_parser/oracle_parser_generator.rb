require 'treetop'
path = File.expand_path(File.dirname(__FILE__))
#Treetop.load 'oracle'
require './oracle'

def dump_node(node, indent='')
  if node == nil || node.class == SqlParser::IgnoreNode
    return
  end

  puts indent + "<#{node.class.name}> #{node.text_value}"
  if node.ast != nil
    case node.ast
    when Treetop::Runtime::SyntaxNode
#      puts node
      node.ast
    when Array
      node.ast.each do |e|
        dump_node(e, indent+' ')
      end
    end
  end
end


parser = SqlParser::OracleParser.new
parsed = parser.parse('select col1, col1 as alias1, table1.*, col1 as alias2 from table1')
#parsed = parser.parse('select col1 as alias1 from table1')
#parsed = parser.parse('select hasdfadfadf,a from')
#parsed = clear_nodes(parsed)

if parsed
  puts "successful"
  dump_node(parsed)
else
  puts "parse unsuccessful at #{parser.index}"
  puts parser.failure_reason
end
