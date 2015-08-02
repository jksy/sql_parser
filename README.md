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
=> #<SqlParser::Ast::SelectStatement
  :subquery => #<SqlParser::Ast::Subquery
    :query_block => #<SqlParser::Ast::QueryBlock
      :hint => nil,
      :modifier => nil,
      :select_list => #<SqlParser::Ast::Array [
        #<SqlParser::Ast::NumberLiteral {:value=>"1"}>
      ]>
      ,
      :select_sources => #<SqlParser::Ast::Identifier {:name=>"dual"}>,
      :where_clause => nil,
      :group_by_clause => nil,
      :model_clause => nil}>
    ,
    :order_by_clause => nil}>
  ,
  :for_update_clause => nil}>
</pre>


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jksy/sql_parser.

