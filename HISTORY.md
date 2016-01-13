### 0.6.0
* Enchancement
  * added travis-ci
  * added oracle enhanced adapter query(select, includes, joins, where)
  * added syntax for column_alias

### 0.5.1
* Bug fix
  * fix spell. to_pameternized is deprecated and will be removed. use to_parameterized 

### 0.5.0
* Enchancement
  * added NumberLiteral#to_cecimal, TextLiteral#to_s

### 0.4.0
* Enchancement
  * rename ParameternizedQuery#query -> ParameternizedQuery#to_sql
  * added grammer
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
* Enchancement
  * support double-quoted identifer

### 0.1.0
* Initial version
