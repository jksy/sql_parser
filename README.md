# SqlParser

SQL Parser for Oracle

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sql_parser'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sql_parser

## Usage

```ruby
query = "select 1 from dual"
parser = SqlParser::Oracle::OracleParser.new
syntax_tree = parser.parse query
if syntax_tree
  message = "\n#{query}\n" + " " * (parser.failure_column.to_i-1) + "*\n"
  raise parser.failure_reason + message
end
ast = syntax_tree.ast
```
<pre>
irb(main):008:0> ast
=> #&lt;SqlParser::Ast::SelectStatement
  :subquery =&gt; #&lt;SqlParser::Ast::Subquery
    :query_block =&gt; #&lt;SqlParser::Ast::QueryBlock
      :hint =&gt; nil,
      :modifier =&gt; nil,
      :select_list =&gt; #&lt;SqlParser::Ast::Array [
        #&lt;SqlParser::Ast::NumberLiteral {:value=&gt;"1"}>
      ]>
      ,
      :select_sources =&gt; #&lt;SqlParser::Ast::Identifier {:name=&gt;"dual"}>,
      :where_clause =&gt; nil,
      :group_by_clause =&gt; nil,
      :model_clause =&gt; nil}>
    ,
    :order_by_clause =&gt; nil}>
  ,
  :for_update_clause =&gt; nil}>
</pre>


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jksy/sql_parser.

## Test Page

http://dev.jksy.org/
