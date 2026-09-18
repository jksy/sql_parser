# OracleSqlParser

[![test](https://github.com/jksy/sql_parser/actions/workflows/test.yml/badge.svg)](https://github.com/jksy/sql_parser/actions/workflows/test.yml)
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

## Development

    $ bundle install
    $ bundle exec rake test:unit  # parser tests, no Oracle required

The parsers under `lib/oracle-sql-parser/grammar/` are generated from the
`.treetop` grammars next to them and the generated `.rb` files are committed.
After editing a grammar (or `reserved_word_generator.rb`), regenerate and
commit the result; CI fails if the committed parsers are out of date:

    $ bundle exec rake gen_force  # compile **/*.treetop

The tests under `test/oracle_enhanced-adapter` run real queries through
[activerecord-oracle_enhanced-adapter](https://github.com/rsim/oracle-enhanced)
and need Oracle Instant Client plus a reachable Oracle database. Their gems are
managed with [Appraisal](https://github.com/thoughtbot/appraisal) so that a
plain `bundle install` works without Oracle:

    $ bundle exec appraisal install
    $ export ORACLE_USERNAME=... ORACLE_PASSWORD=... ORACLE_HOST=localhost ORACLE_PORT=1521 ORACLE_SID=XE
    $ BUNDLE_GEMFILE=gemfiles/adapter_6.gemfile bundle exec rake test:adapter

Connection settings can also be put in `test/oracle_enhanced-adapter/connection_params.yml`
(ignored by git). `rake test` runs both `test:unit` and `test:adapter`.

## Release

1. Update the version in `lib/oracle-sql-parser/version.rb` and merge it.
2. On `master`, run `bundle exec rake release`, which creates the `v<version>`
   tag, pushes it and publishes the gem to [rubygems.org](https://rubygems.org).
3. Create a GitHub Release for the tag and generate the release notes from it.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jksy/sql_parser.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
