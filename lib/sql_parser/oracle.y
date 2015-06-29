class SqlParser::Oracle
prechigh
  left '.'
  nonassoc UMINUS '!'
  left '*' '/'
  left '+' '-'
preclow

rule
  sql: select {val}

  # referenced from http://docs.oracle.com/cd/E16338_01/server.112/b56299/statements_10002.htm
  select: subquery 
    for_update_clause_or_empty {val.join(' ')}   

  for_update_clause_or_empty:
    | for_update_clause

  for_update_clause: FOR UPDATE OF # not implement

  subquery: query_block order_by_clause_or_empty           {puts val; val.join(' ')}
#    | subquery union subquery order_by_clause_or_empty     {val}
#    | subquery INTERSECT subquery order_by_clause_or_empty {val}
#    | subquery MINUS subquery order_by_clause_or_empty     {val}
#    | '(' subquery ')'

  union: UNION all_or_empty {val.join(' ')}

  order_by_clause_or_empty:
    | order_by_clause 

  query_block: subquery_factoring_clause_or_empty
    SELECT hint_or_empty all_or_empty select_list 
    FROM select_sources 
    where_clause_or_empty 
    hierarchical_query_clause_or_empty 
    group_by_clause_or_empty 
    model_clause_or_empty {result = Select.new(val[2], val[3],val[4], val[6], val[7], val[9])}

  subquery_factoring_clause_or_empty:
    | subquery_factoring_clause {val}
  subquery_factoring_clause: WITH # not implement

  hint_or_empty: {val}
    | hint {val}
  hint: HINT # not implement

  all_or_empty: 
     | all
  all: ALL {val}

  select_list: '*' 
    | select_list ',' select_list {result = val}
    | select_list_table 
    | select_list_expr 

  select_list_table: table '.' '*' {result = val}
#    | schema '.' table '.' '*' {result = val}   # not implemented

  select_list_expr:
    | expr 
    | expr c_alias {result = val}
    | expr AS c_alias {result = val}

  c_alias: ident 

  select_sources: select_sources ',' select_source {result = val}
                | select_source 
  select_source: table_reference                   {val}
    | join_clause                                  {val}
    | '(' join_clause ')'                          {val}

  where_clause_or_empty: 
    | where_clause {result = val}

  where_clause: WHERE conditions {result = Where.new(val[1])}

  hierarchical_query_clause_or_empty:
    | hierarchical_query_clause {val}
  hierarchical_query_clause: HIERARCHICAL # not implement

  group_by_clause_or_empty:
    | group_by_clause
  group_by_clause: GROUP # not implement

  model_clause_or_empty:
    | model_clause 
  model_clause: MODEL # not implement

  join_clause: JOIN # not implement

  table_reference: t_alias '.' '*' {val}
    | '*'                          {val}
    | query_table_expression       {val}

  query_table_expression: schema '.' table {val}
    | table {val}
                      
  schema: ident
  table: ident

  t_alias_or_empty:
    | t_alias {val}
  t_alias: ident 

  text_literal: TEXT_LITERAL {result = TextLiteral.new(val[0])}
  number_literal: NUMBER_LITERAL {result = NumberLiteral.new(val[0])}

  conditions: conditions condition {result = val}
    | condition 
  condition: comparision_condition 
    | floating_point_codition 
    | logical_condition
    | model_condition
    | mutiset_condition 
    | pattern_maching_condition 
    | range_condition 
    | null_condition 
    | xml_condition 
    | compound_condition 
    | exists_condition 
    | in_condition 
    | is_of_tyupe_condition 

  comparision_condition: simple_comparision_conditions 
    | group_comparision_conditions

  simple_comparision_conditions: simple_comparision_conditions simple_comparision_condition {result = val}
    | simple_comparision_condition 
  simple_comparision_condition: expr op_eq expr {result = ComparisionCondition.new(val[0], val[1], val[2])}
    | expr '!=' expr {result = ComparisionCondition.new(val[0], val[1], val[2])}
    | expr '^=' expr {result = ComparisionCondition.new(val[0], val[1], val[2])}
    | expr '<>' expr {result = ComparisionCondition.new(val[0], val[1], val[2])}
    | expr '>' expr {result = ComparisionCondition.new(val[0], val[1], val[2])}
    | expr '<' expr {result = ComparisionCondition.new(val[0], val[1], val[2])}
    | expr '>=' expr {result = ComparisionCondition.new(val[0], val[1], val[2])}
    | expr '<=' expr {result = ComparisionCondition.new(val[0], val[1], val[2])}
    | '(' exprs ')' op_eq '(' subquery ')' {result = ComparisionCondition.new(val[1], val[3], val[5])}
    | '(' exprs ')' '!=' '(' subquery ')' {result = ComparisionCondition.new(val[1], val[3], val[5])}
    | '(' exprs ')' '^=' '(' subquery ')' {result = ComparisionCondition.new(val[1], val[3], val[5])}
    | '(' exprs ')' '<>' '(' subquery ')' {result = ComparisionCondition.new(val[1], val[3], val[5])}

  exprs: exprs ',' expr {result = val.join(' ')}
    | expr {val}

  expr: ident {val}
    | text_literal {val}
    | number_literal {val}

  ident: IDENT {Ident.new(val[0])}

  expression_list: expr ',' expr {val}
    | '(' expr ',' expr ')' {val}

  group_comparision_conditions: group_comparision_conditions group_comparision_condition {val}
  group_comparision_condition: GROUP_COMPARISION_CONDITION {val} # not implement

  floating_point_codition: FLOATING_POINT_CODITION {val} # not implement
  logical_condition: LOGICAL_CONDITION {val} # not implement
  model_condition: MODEL_CONDITION {val} # not implement
  mutiset_condition: MUTISET_CONDITION {val} # not implement
  pattern_maching_condition: PATTERN_MACHING_CONDITION {val} # not implement
  range_condition: RANGE_CONDITION {val} # not implement
  null_condition: NULL_CONDITION {val} # not implement
  xml_condition: XML_CONDITION {val} # not implement
  compound_condition: COMPOUND_CONDITION {val} # not implement
  exists_condition: EXISTS_CONDITION {val} # not implement
  in_condition: IN_CONDITION {val} # not implement
  is_of_tyupe_condition: IS_OF_TYUPE_CONDITION {val} # not implement

#  # operators
#  unary_operator: '-' expr {val}
#    | '+' expr {val}
#
#  arithmetic_operator: 

end
---- header
  require 'pp'
  require 'strscan'
  lib = File.expand_path('../', __FILE__)
  require "#{lib}/oracle_reserved_words"
  require "#{lib}/version"
  require "#{lib}/select"
  require "#{lib}/number_literal"
  require "#{lib}/text_literal"
  require "#{lib}/condition"
  require "#{lib}/comparision_condition"
  require "#{lib}/ident"
  require "#{lib}/where"
  WORD_MATCHER_CHARACTERS = 'A-Z0-9_'

  OPERATORS = {
    '.' => '.',
    '*' => '*',
    ',' => ',',
    '+' => :op_plus,
    '-' => :op_minus,
    '!' => :op_not,
    '=' => :op_eq,
    '!=' => :op_neq,
  }
---- inner
  attr_accessor :yydebug
  def parse(str)
    ss = StringScanner.new(str)
    @q = []

    until ss.eos?
      if ss.scan(/ +/) 
        # ignore white space
      elsif ss.scan(/'[^']+'/) 
        @q << [:TEXT_LITERAL, ss.matched]
      elsif ss.scan(/-?\d+/) 
        @q << [:NUMBER_LITERAL, ss.matched]
      elsif matched = match_operator(ss)
        @q << [matched[1], matched[0]]
      elsif ss.scan(self.class.reserved_words_regexp) 
        @q << [ss.matched.upcase.to_sym, ss.matched]
      elsif ss.scan(/[#{WORD_MATCHER_CHARACTERS}]+/i) 
        @q << [:IDENT, ss.matched]
      else
        raise ParseError, "Oracle::parse no matching:#{ss.inspect}:#{ss.string}:L#{__LINE__}"
      end
    end

    @q << [false, false]

    do_parse
  end

  def next_token
    @q.shift
  end

  def self.reserved_words
    OracleReservedWords.words
  end

  def self.reserved_words_regexp
    unless defined? @@reserved_words_regexp
      @@reserved_words_regexp = Regexp.compile(self.reserved_words.map{|word| "#{word}(?=[^#{WORD_MATCHER_CHARACTERS}])"}.join("|"), Regexp::IGNORECASE)
    end

    @@reserved_words_regexp
  end

  def match_operator(ss)
    OPERATORS.keys.each do |operator|
      if ss.peek(operator.length) == operator
        ss.pos = ss.pos + operator.length
        return OPERATORS.assoc operator
      end
    end
    nil
  end

  def on_error(t, val, vstack)
    puts "t:#{t.inspect}"
    puts "val:#{val.inspect}"
    puts "vstack:#{vstack.inspect}"
    raise ParseError, sprintf("\nparse error on value %s (%s)",
                                    val.inspect, token_to_str(t) || '?')
  end

---- footer
  if __FILE__ == $0
    parser = SqlParser::Oracle.new
    begin
      parser.yydebug = true
      p parser.parse "select col1 from table1 where col1 = 1"
#      p parser.parse "select col1 from table1 where table1.col1 = 1"
    rescue Racc::ParseError => e
      $stderr.puts e
    end
  end
