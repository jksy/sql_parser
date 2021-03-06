### 1.0.0
* Pass test on Rails 5.1.7
* Drop support version before 2.3.8
* Added grammer for "SELECT * FROM {table_name} FETCH FIRST {number} ROWS ONLY".
* The grammer is used by Model.limit(10) with Oracle 18g through ActiveRecord
* Remove code for Ruby version 1.9.x

### 0.9.2
* bug fix method not found "keys" on hash

### 0.9.1
* Syntax
  * Three or more ANDs in WHERE clause fails parsing https://github.com/jksy/sql_parser/issues/16

### 0.9.0
* Syntax
  * added cursor expression
  * added datetime expression
  * added interval expression

### 0.8.1
* Fix README.md

### 0.8.0
* Syntax
  * subquery https://github.com/jksy/sql_parser/issues/8
    * "select col1 from table1 union select col2 from table2 union select col3 from table3"
    * "select col1 from table1 union (select col2 from table2)"
  * compound expression https://github.com/jksy/sql_parser/issues/8
    * "select 1-1 from table1"
* Broken changes
  * select_list.
    Ast::Array[ Ast::Ident[..], Ast::Ident[..]] Ast::Array[ Ast::SelectColumn[:expr => Ast::Ident[..]],...]

### 0.7.0
* Syntax
  * table alias, like "select a.* from table1 a". https://github.com/jksy/sql_parser/issues/8

### 0.6.0
* Enchancement
  * added travis-ci
  * added oracle enhanced adapter query(select, includes, joins, where)
* Syntax
  * added syntax for column_alias

### 0.5.1
* Bug fix
  * fix spell. to_pameternized is deprecated and will be removed. use to_parameterized

### 0.5.0
* Enchancement
  * added NumberLiteral#to_cecimal, TextLiteral#to_s

### 0.4.0
* Bugfix
  * rename ParameternizedQuery#query -> ParameternizedQuery#to_sql
* Syntax
  * union [all]
  * intersect
  * minus
  * [inner|outer] join
  * conditions
    * floating point condition
    * multiset condition
    * is_of_type condition

### 0.3.0
* Enchancement
  * added to_parameternized method

* Bug fix
 * to_sql when select multiple column query parsed

### 0.2.0
* Bug fix
  * Identifier[:value => ..] -> Identifier[:name => ..] when use sequence.nextval
  * refactor test cases

### 0.1.1
* Syntax
  * support double-quoted identifer

### 0.1.0
* Initial version
