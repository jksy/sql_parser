# frozen_string_literal: true

# Parses Oracle SQL into an AST that can be turned back into SQL (to_sql)
# or into SQL with bind variables (to_parameterized).
module OracleSqlParser
end
require 'treetop'
require 'bigdecimal'
require 'oracle-sql-parser/version'
require 'oracle-sql-parser/util'
require 'oracle-sql-parser/ast'
require 'oracle-sql-parser/treetop_ext'
require 'oracle-sql-parser/grammar'
