# OracleSqlParser

[![Build Status](https://travis-ci.org/jksy/sql_parser.svg?branch=master)](https://travis-ci.org/jksy/sql_parser)
[![codecov](https://codecov.io/gh/jksy/sql_parser/branch/master/graph/badge.svg?token=0HSMBU0CD8)](https://codecov.io/gh/jksy/sql_parser)

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
=&gt; #&lt;OracleSqlParser::Ast::SelectStatement {:subquery=&gt;#&lt;OracleSqlParser::Ast::Subquery
  :has_parenthesis =&gt; nil,
  :query_block =&gt; #&lt;OracleSqlParser::Ast::QueryBlock
    :hint =&gt; nil,
    :modifier =&gt; nil,
    :select_list =&gt; #&lt;OracleSqlParser::Ast::Array [
      #&lt;OracleSqlParser::Ast::SelectColumn
        :expr =&gt; #&lt;OracleSqlParser::Ast::NumberLiteral {:value=&gt;"1"}&gt;,
        :as =&gt; nil,
        :c_alias =&gt; nil}&gt;

    ]&gt;
    ,
    :select_sources =&gt; #&lt;OracleSqlParser::Ast::Array [
      #&lt;OracleSqlParser::Ast::TableReference {:schema_name=&gt;nil, :table_name=&gt;#&lt;OracleSqlParser::Ast::Identifier {:name=&gt;"dual"}&gt;, :dblink=&gt;nil, :subquery=&gt;nil, :table_alias=&gt;nil}&gt;
    ]&gt;
    ,
    :where_clause =&gt; nil,
    :group_by_clause =&gt; nil,
    :model_clause =&gt; nil}&gt;
  ,
  :subqueries =&gt; nil,
  :subquery =&gt; nil,
  :order_by_clause =&gt; nil}&gt;
, :for_update_clause=&gt;nil}&gt;=> nil
</pre>

```ruby
ast.to_sql
```

<pre>
=&gt; "select 1 from dual"
</pre>

```ruby
p = ast.to_parameterized
p.to_sql
p.params.inspect
```
<pre>
=&gt; "select :a0 from dual"
=&gt; {"a0"=&gt;#&lt;OracleSqlParser::Ast::NumberLiteral {:value=&gt;"1"}&gt;}
</pre>

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jksy/sql_parser.

## Test Page

http://dev.jksy.org/
