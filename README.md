# OracleSqlParser

[![ci](https://github.com/jksy/sql_parser/actions/workflows/ci.yml/badge.svg)](https://github.com/jksy/sql_parser/actions/workflows/ci.yml)
[![codecov](https://codecov.io/gh/jksy/sql_parser/branch/master/graph/badge.svg?token=0HSMBU0CD8)](https://codecov.io/gh/jksy/sql_parser)

SQL Parser for Oracle

## Requirements

Ruby 3.2 or later (CI runs on 3.2, 3.3, 3.4 and 4.0). The gem itself does not
need an Oracle client; only the connection tests described under
[Development](#development) do.

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
and need Oracle Instant Client plus a reachable Oracle database. The easiest
way to get both is the dev container in `.devcontainer/`, which starts
[Oracle Database Free](https://github.com/gvenzl/oci-oracle-free) next to a
Ruby container that has Instant Client installed. Open the repository in the
container (VS Code "Reopen in Container", or the
[devcontainer CLI](https://github.com/devcontainers/cli)) and run the tests:

    $ devcontainer up --workspace-folder .
    $ devcontainer exec --workspace-folder . bundle exec rake test  # test:unit and test:adapter

The Oracle gems are managed with [Appraisal](https://github.com/thoughtbot/appraisal)
so that a plain `bundle install` works without Oracle; `rake test:adapter`
switches to `gemfiles/adapter_6.gemfile` by itself when the current bundle does
not have them. There is one appraisal per ActiveRecord version the tests are
run against (6.1, 7.2 and 8.1, see `Appraisals`); to run the tests with all of
them:

    $ bundle exec appraisal rake test:adapter:run

To run against another Oracle database instead, install the appraisal gems and
point the tests at it:

    $ bundle exec appraisal install
    $ export ORACLE_USERNAME=... ORACLE_PASSWORD=... ORACLE_HOST=localhost ORACLE_PORT=1521 ORACLE_SID=FREEPDB1
    $ bundle exec rake test:adapter

Connection settings can also be put in `test/oracle_enhanced-adapter/connection_params.yml`
(ignored by git).

## Release

Release notes live on [GitHub Releases](https://github.com/jksy/sql_parser/releases)
and are generated from the merged pull requests, grouped by label
(`.github/release.yml`). `CHANGELOG.md` is kept for history only.

1. Open a pull request that updates `lib/oracle-sql-parser/version.rb`, label
   it `release` (so it is left out of the notes) and merge it.
2. On `master`, run `bundle exec rake release`, which creates the `v<version>`
   tag, pushes it and publishes the gem to [rubygems.org](https://rubygems.org).
3. On GitHub, draft a release for the tag, click "Generate release notes" and
   publish it.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jksy/sql_parser.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
