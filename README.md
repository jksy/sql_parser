# OracleSqlParser

SQL Parser for Oracle

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'oracle-sql-parser'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install oracle-sql-parser

## Usage

```ruby
query = "select 1 from dual"
parser = OracleSqlParser::Grammar::GrammarParser.new
syntax_tree = parser.parse query
if syntax_tree.nil?
  message = "\n#{query}\n" + " " * (parser.failure_column.to_i-1) + "*\n"
  raise parser.failure_reason + message
end
ast = syntax_tree.ast
```
<pre>
=&gt; #&lt;OracleSqlParser::Ast::SelectStatement
  :subquery =&gt; #&lt;OracleSqlParser::Ast::Subquery
    :query_block =&gt; #&lt;OracleSqlParser::Ast::QueryBlock
      :hint =&gt; nil,
      :modifier =&gt; nil,
      :select_list =&gt; #&lt;OracleSqlParser::Ast::Array [
        #&lt;OracleSqlParser::Ast::NumberLiteral {:value=&gt;"1"}&gt;
      ]&gt;
      ,
      :select_sources =&gt; #&lt;OracleSqlParser::Ast::TableReference {:schema_name=&gt;nil, :table_name=&gt;#&lt;OracleSqlParser::Ast::Identifier {:name=&gt;"dual"}&gt;, :dblink=&gt;nil}&gt;,
      :where_clause =&gt; nil,
      :group_by_clause =&gt; nil,
      :model_clause =&gt; nil}&gt;
    ,
    :order_by_clause =&gt; nil}&gt;
  ,
  :for_update_clause =&gt; nil}&gt;
</pre>

```ruby
ast.to_sql
```

<pre>
=&gt; "select 1 from dual"
</pre>

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jksy/sql_parser.

## Test Page

http://dev.jksy.org/
