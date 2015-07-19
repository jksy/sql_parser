require File.expand_path('test_helper.rb', File.dirname(__FILE__))

class OracleTest < Test::Unit::TestCase
  def setup
  end

  def teardown
  end

  def parse_successful(query)
    generate_ast(query)
  end

  def ast_sameness?(query, expect)
    actual = generate_ast(query)
    need_equal(expect, actual)
  end

  # select
  def test_select_parseable
    ast_sameness?("select col1 from table1",
       Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Base[[
              Ast::Identifier[:name => 'col1']
            ]],
            :select_sources => Ast::Identifier[:name => 'table1']
          ],
        ],
      ]
    )
  end

  def test_select_all_parseable
    ast_sameness? 'select all col1 from table1',
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :modifier => Ast::Keyword[:name => 'all'],
            :select_list => Ast::Base[[
              Ast::Identifier[:name => 'col1']
            ]],
            :select_sources => Ast::Identifier[:name => 'table1']
          ]
        ]
      ]
  end

  def test_select_distinct_parseable
    ast_sameness? 'select distinct col2 from table1',
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :modifier => Ast::Keyword[:name => 'distinct'],
            :select_list => Ast::Base[[
              Ast::Identifier[:name => 'col2']
            ]],
            :select_sources => Ast::Identifier[:name => 'table1']
          ]
        ]
      ]
  end

  def test_select_unique_parseable
    ast_sameness? 'select unique col2 from table1',
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :modifier => Ast::Keyword[:name => 'unique'],
            :select_list => Ast::Base[[
              Ast::Identifier[:name => 'col2']
            ]],
            :select_sources => Ast::Identifier[:name => 'table1']
          ]
        ]
      ]
  end

  def test_select_union_parseable
    # do not support union ast
    parse_successful 'select col1 from table1 union select col1 from table2'
  end

  def test_select_union_all_parseable
    # do not support union ast
    parse_successful 'select col1 from table1 union all select col1 from table2'
  end

  def test_select_intersect_parseable
   # do not support intersect ast
    parse_successful 'select col1 from table1 intersect select col1 from table2'
  end

  def test_select_minus_parseable
   # do not support minus ast
    parse_successful 'select col1 from table1 minus select col1 from table2'
  end

  def test_select_literal_number_column_parseable
    ast_sameness? 'select 1 from table1',
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Base[[
              Ast::NumberLiteral[:value => '1']
            ]],
            :select_sources => Ast::Identifier[:name => 'table1']
          ]
        ]
      ]
  end

  def test_select_literal_nagative_number_column_parseable
    ast_sameness? 'select -1 from table1',
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Base[[
              Ast::NumberLiteral[:value => '-1']
            ]],
            :select_sources => Ast::Identifier[:name => 'table1']
          ]
        ]
      ]
  end

  def test_select_literal_float_number_column_parseable
    ast_sameness? 'select 1.1 from table1',
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Base[[
              Ast::NumberLiteral[:value => '1.1']
            ]],
            :select_sources => Ast::Identifier[:name => 'table1']
          ]
        ]
      ]
  end

  def test_select_literal_float_nagavite_number_column_parseable
    ast_sameness? 'select -1.1 from table1', 
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Base[[
              Ast::NumberLiteral[:value => '-1.1']
            ]],
            :select_sources => Ast::Identifier[:name => 'table1']
          ]
        ]
      ]
  end

  def test_select_literal_string_parseable
    ast_sameness? "select 'adslfael' from table1" ,
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Base[[
              Ast::TextLiteral[:value => 'adslfael']
            ]],
            :select_sources => Ast::Identifier[:name => 'table1']
          ]
        ]
      ]
  end

  def test_select_asterisk_parseable
    ast_sameness? "select * from table1",
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Base[[
              Ast::Identifier[:name => '*']
            ]],
            :select_sources => Ast::Identifier[:name => 'table1']
          ]
        ]
      ]
  end

  def test_select_table_and_asterisk_parseable
    ast_sameness? "select table1.* from table1",
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Base[[
              Ast::Identifier[:name => 'table1.*']
            ]],
            :select_sources => Ast::Identifier[:name => 'table1']
          ]
        ]
      ]
  end

  def test_join_clause_parseable
    # do not support join clause ast
    parse_successful "select * from table1 inner join table2 on table1.col1 = table2.col1"
  end

  def test_inner_join_clause_with_on_parseable
    # do not support join clause ast
    parse_successful "select * from table1 inner join table2 on table1.col1 = table2.col1"
  end

  def test_inner_join_clause_with_using_parseable
    # do not support join clause ast
    parse_successful "select * from table1 inner join table2 using (col1, col2)"
  end

  def test_cross_join_clause_parseable
    # do not support join clause ast
    parse_successful "select * from table1 cross join table2"
  end

  def test_cross_join_clause_with_natual_parseable
    # do not support join clause ast
    parse_successful "select * from table1 natural join table2"
  end

  def test_cross_join_clause_with_natural_using_parseable
    # do not support join clause ast
    parse_successful "select * from table1 natural inner join table2"
  end

  def test_outer_join_clause_full_join_parseable
    # do not support join clause ast
    parse_successful "select * from table1 full outer join table2 on table1.col1 = table2.col2"
  end

  def test_outer_join_clause_left_join_parseable
    # do not support join clause ast
    parse_successful "select * from table1 left join table2 on table1.col1 = table2.col2"
  end

  def test_outer_join_clause_right_join_parseable
    # do not support join clause ast
    parse_successful "select * from table1 right join table2 on table1.col1 = table2.col2"
  end

  def test_outer_join_clause_natural_join_parseable
    # do not support join clause ast
    parse_successful "select * from table1 natural join table2 on table1.col1 = table2.col2"
  end

  def test_outer_join_clause_natural_jointype_parseable
    # do not support join clause ast
    parse_successful "select * from table1 natural left join table2 on table1.col1 = table2.col2"
  end

  def test_outer_join_clause_using_parseable
    # do not support join clause ast
    parse_successful "select * from table1 natural left join table2 using (col1, col2)"
  end

  def test_select_where_parseable
    ast_sameness? "select * from table1 where col1 = col1",
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Base[[
              Ast::Identifier[:name => '*']
            ]],
            :select_sources => Ast::Identifier[:name => 'table1'],
            :where_clause => Ast::WhereClause[
              :condition => Ast::SimpleComparisionCondition[
                :left => Ast::Identifier[:name => 'col1'],
                :op => '=',
                :right => Ast::Identifier[:name => 'col1']
              ]
            ]
          ]
        ]
      ]
  end

  def test_select_where_with_literal_textparseable
    ast_sameness? "select * from table1 where col1 = 'abc'",
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Base[[
              Ast::Identifier[:name => '*']
            ]],
            :select_sources => Ast::Identifier[:name => 'table1'],
            :where_clause => Ast::WhereClause[
              :condition => Ast::SimpleComparisionCondition[
                :left => Ast::Identifier[:name => 'col1'],
                :op => '=',
                :right => Ast::TextLiteral[:value => 'abc']
              ]
            ]
          ]
        ]
      ]
  end

  def test_select_where_with_literal_number_parseable
    ast_sameness? "select * from table1 where col1 = -1",
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Base[[
              Ast::Identifier[:name => '*']
            ]],
            :select_sources => Ast::Identifier[:name => 'table1'],
            :where_clause => Ast::WhereClause[
              :condition => Ast::SimpleComparisionCondition[
                :left => Ast::Identifier[:name => 'col1'],
                :op => '=',
                :right => Ast::NumberLiteral[:value => '-1']
              ]
            ]
          ]
        ]
      ]
  end

  def test_select_where_with_neq1_parseable
    ast_sameness? "select * from table1 where col1 != 1",
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Base[[
              Ast::Identifier[:name => '*']
            ]],
            :select_sources => Ast::Identifier[:name => 'table1'],
            :where_clause => Ast::WhereClause[
              :condition => Ast::SimpleComparisionCondition[
                :left => Ast::Identifier[:name => 'col1'],
                :op => '!=',
                :right => Ast::NumberLiteral[:value => '1']
              ]
            ]
          ]
        ]
      ]
  end

  def test_select_where_with_neq2_parseable
    ast_sameness? "select * from table1 where col1 ^= 1",
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Base[[
              Ast::Identifier[:name => '*']
            ]],
            :select_sources => Ast::Identifier[:name => 'table1'],
            :where_clause => Ast::WhereClause[
              :condition => Ast::SimpleComparisionCondition[
                :left => Ast::Identifier[:name => 'col1'],
                :op => '^=',
                :right => Ast::NumberLiteral[:value => '1']
              ]
            ]
          ]
        ]
      ]
  end

  def test_select_where_with_neq3_parseable
    ast_sameness? "select * from table1 where col1 <> 1",
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Base[[
              Ast::Identifier[:name => '*']
            ]],
            :select_sources => Ast::Identifier[:name => 'table1'],
            :where_clause => Ast::WhereClause[
              :condition => Ast::SimpleComparisionCondition[
                :left => Ast::Identifier[:name => 'col1'],
                :op => '<>',
                :right => Ast::NumberLiteral[:value => '1']
              ]
            ]
          ]
        ]
      ]
  end

  def test_select_where_with_less_equal_parseable
    ast_sameness? "select * from table1 where col1 <= 1",
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Base[[
              Ast::Identifier[:name => '*']
            ]],
            :select_sources => Ast::Identifier[:name => 'table1'],
            :where_clause => Ast::WhereClause[
              :condition => Ast::SimpleComparisionCondition[
                :left => Ast::Identifier[:name => 'col1'],
                :op => '<=',
                :right => Ast::NumberLiteral[:value => '1']
              ]
            ]
          ]
        ]
      ]
  end

  def test_select_where_with_grater_equal_parseable
    ast_sameness? "select * from table1 where col1 >= 1",
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Base[[
              Ast::Identifier[:name => '*']
            ]],
            :select_sources => Ast::Identifier[:name => 'table1'],
            :where_clause => Ast::WhereClause[
              :condition => Ast::SimpleComparisionCondition[
                :left => Ast::Identifier[:name => 'col1'],
                :op => '>=',
                :right => Ast::NumberLiteral[:value => '1']
              ]
            ]
          ]
        ]
      ]
  end

  def test_select_where_with_logical_and_conditions_parseable
    ast_sameness? "select * from table1 where col1 = col2 and col3 = col4",
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Base[[
              Ast::Identifier[:name => '*']
            ]],
            :select_sources => Ast::Identifier[:name => 'table1'],
            :where_clause => Ast::WhereClause[
              :condition => Ast::LogicalCondition[
                :left => Ast::SimpleComparisionCondition[
                  :left => Ast::Identifier[:name => 'col1'],
                  :op => '=',
                  :right => Ast::Identifier[:name => 'col2']
                ],
                :op => Ast::Keyword[:name => 'and'],
                :right => Ast::SimpleComparisionCondition[
                  :left => Ast::Identifier[:name => 'col3'],
                  :op => '=',
                  :right => Ast::Identifier[:name => 'col4']
                ]
              ]
            ]
          ]
        ]
      ]
  end

  def test_select_where_with_logical_or_conditions_parseable
    ast_sameness? "select * from table1 where col1 = col2 or col3 = col4", 
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Base[[
              Ast::Identifier[:name => '*']
            ]],
            :select_sources => Ast::Identifier[:name => 'table1'],
            :where_clause => Ast::WhereClause[
              :condition => Ast::LogicalCondition[
                :left => Ast::SimpleComparisionCondition[
                  :left => Ast::Identifier[:name => 'col1'],
                  :op => '=',
                  :right => Ast::Identifier[:name => 'col2']
                ],
                :op => Ast::Keyword[:name => 'or'],
                :right => Ast::SimpleComparisionCondition[
                  :left => Ast::Identifier[:name => 'col3'],
                  :op => '=',
                  :right => Ast::Identifier[:name => 'col4']
                ]
              ]
            ]
          ]
        ]
      ]
      
  end

  def test_select_where_with_like_onditions_parseable
    ast_sameness? "select * from table1 where col1 like 'abc%'",
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Base[[
              Ast::Identifier[:name => '*']
            ]],
            :select_sources => Ast::Identifier[:name => 'table1'],
            :where_clause => Ast::WhereClause[
              :condition => Ast::LikeCondition[
                :target => Ast::Identifier[:name => 'col1'],
                :like => Ast::Keyword[:name => 'like'],
                :text => Ast::TextLiteral[:value => 'abc%']
              ]
            ]
          ]
        ]
      ]
  end

  def test_select_where_with_likec_onditions_parseable
    ast_sameness? "select * from table1 where col1 likec 'abc%'",
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Base[[
              Ast::Identifier[:name => '*']
            ]],
            :select_sources => Ast::Identifier[:name => 'table1'],
            :where_clause => Ast::WhereClause[
              :condition => Ast::LikeCondition[
                :target => Ast::Identifier[:name => 'col1'],
                :like => Ast::Keyword[:name => 'likec'],
                :text => Ast::TextLiteral[:value => 'abc%']
              ]
            ]
          ]
        ]
      ]
  end

  def test_select_where_with_like2_onditions_parseable
    ast_sameness? "select * from table1 where col1 like2 'abc%'",
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Base[[
              Ast::Identifier[:name => '*']
            ]],
            :select_sources => Ast::Identifier[:name => 'table1'],
            :where_clause => Ast::WhereClause[
              :condition => Ast::LikeCondition[
                :target => Ast::Identifier[:name => 'col1'],
                :like => Ast::Keyword[:name => 'like2'],
                :text => Ast::TextLiteral[:value => 'abc%']
              ]
            ]
          ]
        ]
      ]
  end

  def test_select_where_with_like4_onditions_parseable
    ast_sameness? "select * from table1 where col1 like4 'abc%'",
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Base[[
              Ast::Identifier[:name => '*']
            ]],
            :select_sources => Ast::Identifier[:name => 'table1'],
            :where_clause => Ast::WhereClause[
              :condition => Ast::LikeCondition[
                :target => Ast::Identifier[:name => 'col1'],
                :like => Ast::Keyword[:name => 'like4'],
                :text => Ast::TextLiteral[:value => 'abc%']
              ]
            ]
          ]
        ]
      ]
  end

  def test_select_where_with_not_like_onditions_parseable
    ast_sameness? "select * from table1 where col1 not like 'abc%'",
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Base[[
              Ast::Identifier[:name => '*']
            ]],
            :select_sources => Ast::Identifier[:name => 'table1'],
            :where_clause => Ast::WhereClause[
              :condition => Ast::LikeCondition[
                :target => Ast::Identifier[:name => 'col1'],
                :not => Ast::Keyword[:name => 'not'],
                :like => Ast::Keyword[:name => 'like'],
                :text => Ast::TextLiteral[:value => 'abc%']
              ]
            ]
          ]
        ]
      ]
  end

  def test_select_where_with_like_escape_conditions_parseable
    ast_sameness? "select * from table1 where col1 like 'abc%' escape '@'",
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Base[[
              Ast::Identifier[:name => '*']
            ]],
            :select_sources => Ast::Identifier[:name => 'table1'],
            :where_clause => Ast::WhereClause[
              :condition => Ast::LikeCondition[
                :target => Ast::Identifier[:name => 'col1'],
                :like => Ast::Keyword[:name => 'like'],
                :text => Ast::TextLiteral[:value => 'abc%'],
                :escape => Ast::TextLiteral[:value => '@']
              ]
            ]
          ]
        ]
      ]
  end

  def test_select_where_with_regexp_like_conditions_parseable
    ast_sameness? "select * from table1 where regexp_like(col1,  '^Ste(v|ph)en$')",
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Base[[
              Ast::Identifier[:name => '*']
            ]],
            :select_sources => Ast::Identifier[:name => 'table1'],
            :where_clause => Ast::WhereClause[
              :condition => Ast::RegexpCondition[
                :target => Ast::Identifier[:name => 'col1'],
                :regexp => Ast::TextLiteral[:value => '^Ste(v|ph)en$']
              ]
            ]
          ]
        ]
      ]
  end

  def test_select_where_with_null_conditions_parseable
    ast_sameness? "select * from table1 where col1 is null", 
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Base[[
              Ast::Identifier[:name => '*']
            ]],
            :select_sources => Ast::Identifier[:name => 'table1'],
            :where_clause => Ast::WhereClause[
              :condition => Ast::NullCondition[
                :target => Ast::Identifier[:name => 'col1'],
                :not => nil
              ]
            ]
          ]
        ]
      ]
  end

  def test_select_where_with_not_null_conditions_parseable
    ast_sameness? "select * from table1 where col1 is not null",
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Base[[
              Ast::Identifier[:name => '*']
            ]],
            :select_sources => Ast::Identifier[:name => 'table1'],
            :where_clause => Ast::WhereClause[
              :condition => Ast::NullCondition[
                :target => Ast::Identifier[:name => 'col1'],
                :not => Ast::Keyword[:name => 'not']
              ]
            ]
          ]
        ]
      ]
  end

  def test_select_where_with_compodition_conditions_parseable
    ast_sameness? "select * from table1 where (col1 = col2)",
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Base[[
              Ast::Identifier[:name => '*']
            ]],
            :select_sources => Ast::Identifier[:name => 'table1'],
            :where_clause => Ast::WhereClause[
              :condition => Ast::SimpleComparisionCondition[
                :left => Ast::Identifier[:name => 'col1'],
                :op => '=',
                :right => Ast::Identifier[:name => 'col2']
              ]
            ]
          ]
        ]
      ]
  end

  def test_select_where_with_compodition_not_conditions_parseable
    ast_sameness? "select * from table1 where not col1 = col2",
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Base[[
              Ast::Identifier[:name => '*']
            ]],
            :select_sources => Ast::Identifier[:name => 'table1'],
            :where_clause => Ast::WhereClause[
              :condition => Ast::LogicalCondition[
                :op => Ast::Keyword[:name => 'not'],
                :right => Ast::SimpleComparisionCondition[
                  :left => Ast::Identifier[:name => 'col1'],
                  :op => '=',
                  :right => Ast::Identifier[:name => 'col2']
                ]
              ]
            ]
          ]
        ]
      ]
  end

  def test_select_where_with_between_conditions_parseable
    ast_sameness? "select * from table1 where col1 between col2 and col3",
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Base[[
              Ast::Identifier[:name => '*']
            ]],
            :select_sources => Ast::Identifier[:name => 'table1'],
            :where_clause => Ast::WhereClause[
              :condition => Ast::BetweenCondition[
                :target => Ast::Identifier[:name => 'col1'],
                :from => Ast::Identifier[:name => 'col2'],
                :to => Ast::Identifier[:name => 'col3']
              ]
            ]
          ]
        ]
      ]
  end

  def test_select_where_with_not_between_conditions_parseable
    ast_sameness? "select * from table1 where col1 not between col2 and col3",
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Base[[
              Ast::Identifier[:name => '*']
            ]],
            :select_sources => Ast::Identifier[:name => 'table1'],
            :where_clause => Ast::WhereClause[
              :condition => Ast::BetweenCondition[
                :target => Ast::Identifier[:name => 'col1'],
                :not => Ast::Keyword[:name => 'not'],
                :from => Ast::Identifier[:name => 'col2'],
                :to => Ast::Identifier[:name => 'col3']
              ]
            ]
          ]
        ]
      ]

  end

  def test_select_where_with_between_number_conditions_parseable
    ast_sameness? "select * from table1 where col1 between 1 and 100",
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Base[[
              Ast::Identifier[:name => '*']
            ]],
            :select_sources => Ast::Identifier[:name => 'table1'],
            :where_clause => Ast::WhereClause[
              :condition => Ast::BetweenCondition[
                :target => Ast::Identifier[:name => 'col1'],
                :from => Ast::NumberLiteral[:value => '1'],
                :to => Ast::NumberLiteral[:value => '100']
              ]
            ]
          ]
        ]
      ]
  end

  def test_select_where_with_between_string_conditions_parseable
    ast_sameness? "select * from table1 where col1 between 'a' and 'z'",
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Base[[
              Ast::Identifier[:name => '*']
            ]],
            :select_sources => Ast::Identifier[:name => 'table1'],
            :where_clause => Ast::WhereClause[
              :condition => Ast::BetweenCondition[
                :target => Ast::Identifier[:name => 'col1'],
                :from => Ast::TextLiteral[:value => 'a'],
                :to => Ast::TextLiteral[:value => 'z']
              ]
            ]
          ]
        ]
      ]
  end

  def test_select_where_with_exists_condition_parseable
    ast_sameness? "select * from table1 where exists (select 1 from table2)",
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Base[[
              Ast::Identifier[:name => '*']
            ]],
            :select_sources => Ast::Identifier[:name => 'table1'],
            :where_clause => Ast::WhereClause[
              :condition => Ast::ExistsCondition[
                :target => generate_ast("select 1 from table2").subquery
              ]
            ]
          ]
        ]
      ]
  end

  def test_select_where_with_not_exists_condition_parseable
    ast_sameness? "select * from table1 where not exists (select 1 from table2)",
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Base[[
              Ast::Identifier[:name => '*']
            ]],
            :select_sources => Ast::Identifier[:name => 'table1'],
            :where_clause => Ast::WhereClause[
              :condition => Ast::LogicalCondition[
                :op => Ast::Keyword[:name => 'not'],
                :right => Ast::ExistsCondition[
                  :target => generate_ast("select 1 from table2").subquery
                ]
              ]
            ]
          ]
        ]
      ]
  end

  def test_select_where_in_expr_condition_parseable
    ast_sameness? "select * from table1 where col1 in (1)",
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Base[[
              Ast::Identifier[:name => '*']
            ]],
            :select_sources => Ast::Identifier[:name => 'table1'],
            :where_clause => Ast::WhereClause[
              :condition => Ast::InCondition[
                :target => Ast::Identifier[:name => 'col1'],
                :values => Ast::Base[
                  [Ast::NumberLiteral[:value => '1']]
                ]
              ]
            ]
          ]
        ]
      ]
  end

  def test_select_where_not_in_expr_condition_parseable
    ast_sameness? "select * from table1 where col1 not in (1)" ,
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Base[[
              Ast::Identifier[:name => '*']
            ]],
            :select_sources => Ast::Identifier[:name => 'table1'],
            :where_clause => Ast::WhereClause[
              :condition => Ast::InCondition[
                :target => Ast::Identifier[:name => 'col1'],
                :not => Ast::Keyword[:name => 'not'],
                :values => Ast::Base[
                  [Ast::NumberLiteral[:value => '1']]
                ]
              ]
            ]
          ]
        ]
      ]
  end

  def test_select_where_in_subquery_condition_parseable
    ast_sameness? "select * from table1 where col1 in (select * from table2)",
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Base[[
              Ast::Identifier[:name => '*']
            ]],
            :select_sources => Ast::Identifier[:name => 'table1'],
            :where_clause => Ast::WhereClause[
              :condition => Ast::InCondition[
                :target => Ast::Identifier[:name => 'col1'],
                :values => generate_ast("select * from table2").subquery
              ]
            ]
          ]
        ]
      ]
  end

  def test_select_where_not_in_subquery_condition_parseable
    ast_sameness? "select * from table1 where col1 not in (select * from table2)",
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Base[[
              Ast::Identifier[:name => '*']
            ]],
            :select_sources => Ast::Identifier[:name => 'table1'],
            :where_clause => Ast::WhereClause[
              :condition => Ast::InCondition[
                :target => Ast::Identifier[:name => 'col1'],
                :not => Ast::Keyword[:name => 'not'],
                :values => generate_ast("select * from table2").subquery
              ]
            ]
          ]
        ]
      ]
  end

  def test_select_group_by_expr_parseable
    ast_sameness? "select * from table1 group by col1, col2",
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Base[[
              Ast::Identifier[:name => '*']
            ]],
            :select_sources => Ast::Identifier[:name => 'table1'],
            :group_by_clause => Ast::GroupByClause[
              :targets => Ast::Base[[
                Ast::Identifier[:name => 'col1'],
                Ast::Identifier[:name => 'col2']
              ]]
            ]
          ]
        ]
      ]
  end

  def test_select_group_by_having_condition_parseable
    ast_sameness? "select * from table1 group by col1, col2 having col1 = col2",
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Base[[
              Ast::Identifier[:name => '*']
            ]],
            :select_sources => Ast::Identifier[:name => 'table1'],
            :group_by_clause => Ast::GroupByClause[
              :targets => Ast::Base[[
                Ast::Identifier[:name => 'col1'],
                Ast::Identifier[:name => 'col2']
              ]],
              :having => Ast::SimpleComparisionCondition[
                :left => Ast::Identifier[:name => 'col1'],
                :op => '=',
                :right => Ast::Identifier[:name => 'col2']
              ]
            ]
          ]
        ]
      ]
  end

  def test_select_rollup_clause_parseable
    ast_sameness? "select * from table1 group by rollup(col1, col2)",
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Base[[
              Ast::Identifier[:name => '*']
            ]],
            :select_sources => Ast::Identifier[:name => 'table1'],
            :group_by_clause => Ast::GroupByClause[
              :targets => Ast::Base[[
                Ast::RollupCubeClause[
                  :func_name => Ast::Keyword[:name => 'rollup'],
                  :args => Ast::Base[[
                    Ast::Identifier[:name => 'col1'],
                    Ast::Identifier[:name => 'col2']
                  ]]
                ],
              ]]
            ]
          ]
        ]
      ]
  end

  def test_select_cube_clause_parseable
    ast_sameness? "select * from table1 group by cube(col1, col2)",
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Base[[
              Ast::Identifier[:name => '*']
            ]],
            :select_sources => Ast::Identifier[:name => 'table1'],
            :group_by_clause => Ast::GroupByClause[
              :targets => Ast::Base[[
                Ast::RollupCubeClause[
                  :func_name => Ast::Keyword[:name => 'cube'],
                  :args => Ast::Base[[
                    Ast::Identifier[:name => 'col1'],
                    Ast::Identifier[:name => 'col2']
                  ]]
                ],
              ]]
            ]
          ]
        ]
      ]
  end

  def test_select_for_update_clause_parseable
    ast_sameness? "select * from table1 for update",
      Ast::SelectStatement[
        :subquery => generate_ast("select * from table1").subquery,
        :for_update_clause => Ast::ForUpdateClause[]
      ]
  end

  def test_select_for_update_clause_column_parseable
    ast_sameness? "select * from table1 for update of column1",
      Ast::SelectStatement[
        :subquery => generate_ast("select * from table1").subquery,
        :for_update_clause => Ast::ForUpdateClause[
          :columns => Ast::Base[[
            Ast::Identifier[:name => 'column1']
          ]]
        ]
      ]
  end

  def test_select_for_update_clause_table_and_column_parseable
    ast_sameness? "select * from table1 for update of table1.column1",
      Ast::SelectStatement[
        :subquery => generate_ast("select * from table1").subquery,
        :for_update_clause => Ast::ForUpdateClause[
          :columns => Ast::Base[[
            Ast::Identifier[:name => 'table1.column1']
          ]]
        ]
      ]
  end

  def test_select_for_update_clause_schema_and_table_and_column_parseable
    ast_sameness? "select * from table1 for update of schema1.table1.column1",
      Ast::SelectStatement[
        :subquery => generate_ast("select * from table1").subquery,
        :for_update_clause => Ast::ForUpdateClause[
          :columns => Ast::Base[[
            Ast::Identifier[:name => 'schema1.table1.column1']
          ]]
        ]
      ]
  end

  def test_select_for_update_clause_nowait_parseable
    ast_sameness? "select * from table1 for update nowait",
      Ast::SelectStatement[
        :subquery => generate_ast("select * from table1").subquery,
        :for_update_clause => Ast::ForUpdateClause[
          :wait => Ast::Keyword[:name => 'nowait']
        ]
      ]
  end

  def test_select_for_update_clause_wait_parseable
    ast_sameness? "select * from table1 for update wait 1",
      Ast::SelectStatement[
        :subquery => generate_ast("select * from table1").subquery,
        :for_update_clause => Ast::ForUpdateClause[
          :wait => Ast::NumberLiteral[:value => '1']
        ]
      ]
  end

  def test_select_order_by_clause_expr_parseable
    ast_sameness? "select * from table1 order by col1",
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => generate_ast("select * from table1").subquery.query_block,
          :order_by_clause => Ast::OrderByClause[
            :items => Ast::Base[[
              Ast::OrderByClauseItem[
                :target => Ast::Identifier[:name => 'col1']
              ]
            ]]
          ]
        ]
      ]
  end

  def test_select_order_by_clause_position_parseable
    ast_sameness? "select * from table1 order by 1",
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => generate_ast("select * from table1").subquery.query_block,
          :order_by_clause => Ast::OrderByClause[
            :items => Ast::Base[[
              Ast::OrderByClauseItem[
                :target => Ast::NumberLiteral[:value => '1']
              ]
            ]]
          ]
        ]
      ]
  end

  def test_select_order_by_clause_siblings_parseable
    ast_sameness? "select * from table1 order siblings by 1",
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => generate_ast("select * from table1").subquery.query_block,
          :order_by_clause => Ast::OrderByClause[
            :siblings => Ast::Keyword[:name => 'siblings'],
            :items => Ast::Base[[
              Ast::OrderByClauseItem[
                :target => Ast::NumberLiteral[:value => '1']
              ]
            ]]
          ]
        ]
      ]
  end

  def test_select_order_by_clause_asc_parseable
    ast_sameness? "select * from table1 order by col1 asc",
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => generate_ast("select * from table1").subquery.query_block,
          :order_by_clause => Ast::OrderByClause[
            :items => Ast::Base[[
              Ast::OrderByClauseItem[
                :target => Ast::Identifier[:name => 'col1'],
                :asc => Ast::Keyword[:name => 'asc']
              ]
            ]]
          ]
        ]
      ]
  end

  def test_select_order_by_clause_desc_parseable
    ast_sameness? "select * from table1 order by col1 desc",
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => generate_ast("select * from table1").subquery.query_block,
          :order_by_clause => Ast::OrderByClause[
            :items => Ast::Base[[
              Ast::OrderByClauseItem[
                :target => Ast::Identifier[:name => 'col1'],
                :asc => Ast::Keyword[:name => 'desc']
              ]
            ]]
          ]
        ]
      ]
  end

  def test_select_order_by_clause_nulls_first_parseable
    ast_sameness? "select * from table1 order by col1 nulls first",
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => generate_ast("select * from table1").subquery.query_block,
          :order_by_clause => Ast::OrderByClause[
            :items => Ast::Base[[
              Ast::OrderByClauseItem[
                :target => Ast::Identifier[:name => 'col1'],
                :nulls => Ast::Keyword[:name => 'first']
              ]
            ]]
          ]
        ]
      ]
  end

  def test_select_order_by_clause_nulls_last_parseable
    ast_sameness? "select * from table1 order by col1 nulls last",
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => generate_ast("select * from table1").subquery.query_block,
          :order_by_clause => Ast::OrderByClause[
            :items => Ast::Base[[
              Ast::OrderByClauseItem[
                :target => Ast::Identifier[:name => 'col1'],
                :nulls => Ast::Keyword[:name => 'last']
              ]
            ]]
          ]
        ]
      ]
  end

  def test_select_order_by_clause_plural_column_parseable
    ast_sameness? "select * from table1 order by col1 asc, col2 desc",
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => generate_ast("select * from table1").subquery.query_block,
          :order_by_clause => Ast::OrderByClause[
            :items => Ast::Base[[
              Ast::OrderByClauseItem[
                :target => Ast::Identifier[:name => 'col1'],
                :asc => Ast::Keyword[:name => 'asc']
              ],
              Ast::OrderByClauseItem[
                :target => Ast::Identifier[:name => 'col2'],
                :asc => Ast::Keyword[:name => 'desc']
              ]
            ]]
          ]
        ]
      ]
  end

  # update
  def test_update_parseable
    ast_sameness? "update table1 set col1 = 1",
      Ast::UpdateStatement[
        :target => Ast::Identifier[:name => 'table1'],
        :set => Ast::Base[[
            Ast::UpdateSetColumn[:column_name => Ast::Identifier[:name => 'col1'],
                                 :op => '=',
                                 :value => Ast::NumberLiteral[:value => '1']]
        ]]
      ]
  end

  def test_update_plural_column_parseable
    ast_sameness? "update table1 set col1 = 1, col2 = 2",
      Ast::UpdateStatement[
        :target => Ast::Identifier[:name => 'table1'],
        :set => Ast::Base[
          [
            Ast::UpdateSetColumn[:column_name => Ast::Identifier[:name => 'col1'],
                                 :op => '=',
                                 :value => Ast::NumberLiteral[:value => '1']],
            Ast::UpdateSetColumn[:column_name => Ast::Identifier[:name => 'col2'],
                                 :op => '=',
                                 :value => Ast::NumberLiteral[:value => '2']]
          ]
        ]
      ]
  end

  def test_update_condition_parseable
    ast = generate_ast("update table1 set col1 = 1")
    ast_sameness? "update table1 set col1 = 1 where col2 = 1",
      Ast::UpdateStatement[
        :target => ast.target,
        :set => ast.set,
        :condition => Ast::WhereClause[
          Ast::SimpleComparisionCondition[
            :left => Ast::Identifier[:name => 'col2'],
            :op => '=',
            :right => Ast::NumberLiteral[:value => '1']
          ]
        ]
      ]
  end

  def test_update_current_of_condition_parseable
    ast = generate_ast("update table1 set col1 = 1")
    ast_sameness? "update table1 set col1 = 1 where current_of cursor_name",
      Ast::UpdateStatement[
        :target => ast.target,
        :set => ast.set,
        :condition => Ast::WhereClause[
          SqlParser::Ast::CurrentOf[
            :cursor_name => Ast::Identifier[:name => 'cursor_name']
          ]
        ]
      ]
  end

  # expression
  def test_simple_expression_rownum_parseable
    parse_successful "select rownum from dual"
  end

  def test_simple_expression_text_literal_parseable
    parse_successful "select 'asdlfjasldfja' from dual"
  end

  def test_simple_expression_number_literal_parseable
    parse_successful "select 13123 from dual"
  end

  def test_simple_expression_sequence_nextval_parseable
    parse_successful "select sequence_name.nextval from dual"
  end

  def test_simple_expression_sequence_currval_parseable
    parse_successful "select sequence_name.currval from dual"
  end

  def test_simple_expression_null_parseable
    parse_successful "select null from dual"
  end

  def test_simple_expression_column_by_schema_table_column_parseable
    parse_successful "select schema1.table1.column1 from dual"
  end

  def test_simple_expression_column_by_table_column_parseable
    parse_successful "select table1.column1 from dual"
  end

  def test_simple_expression_column_by_column_parseable
    parse_successful "select column1 from dual"
  end

  def test_simple_expression_column_by_rowid_parseable
    parse_successful "select rowid from dual"
  end

  def test_simple_case_expression_parseable
    parse_successful "select case credit_limit when 100 then 'low' when 5000 then 'high' end from customers"
  end

  def test_simple_case_expression_else_parseable
    parse_successful "select case credit_limit when 100 then 'low' when 5000 then 'high' else 'medium' end from customers"
  end

  def test_searched_case_expression_else_parseable
    parse_successful "select case when salary > 2000 then salary else 2000 end from customers"
  end

  def test_function_expression_no_args_parseable
    parse_successful "select func() from dual"
  end

  def test_function_expression_one_args_parseable
    parse_successful "select one_arg_function(col1) from customers"
  end

  def test_function_expression_two_args_parseable
    parse_successful "select two_args_function(1, '0') from dual"
  end

  def test_function_expression_package_name_parseable
    parse_successful "select package_name.procedure_name(col1) from customers"
  end

  def test_function_expression_function_in_args_parseable
    parse_successful "select to_date(to_char(sysdate, 'yyyy/mm/dd hh24:mi:ss')) from dual"
  end

  # delete
  def test_delete_parseable
    parse_successful "delete from table1"
  end

  def test_delete_target_table_reference_parseable
    parse_successful "delete from table1"
  end

  def test_delete_target_table_subquery_parseable
    parse_successful "delete from (select 1 from dual)"
  end

  def test_delete_target_table_keyword_parseable
    parse_successful "delete from table (select 1 from dual)"
  end

  def test_delete_target_alias_parseable
    parse_successful "delete from table1 table_alias"
  end

  def test_delete_condition_with_search_condition_parseable
    parse_successful "delete from table1 where col1 = 1"
  end

  def test_delete_condition_with_current_of_parseable
    parse_successful "delete from table1 where current_of cursor_name"
  end

end
