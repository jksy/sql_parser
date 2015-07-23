require File.expand_path('test_helper.rb', File.dirname(__FILE__))

class OracleSelect < Base
  def test_select_parseable
    same_ast?("select col1 from table1",
       Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Array[
              Ast::Identifier[:name => 'col1']
            ],
            :select_sources => Ast::Identifier[:name => 'table1']
          ],
        ],
      ]
    )
  end

  def test_select_all_parseable
    same_ast? 'select all col1 from table1',
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :modifier => Ast::Keyword[:name => 'all'],
            :select_list => Ast::Array[
              Ast::Identifier[:name => 'col1']
            ],
            :select_sources => Ast::Identifier[:name => 'table1']
          ]
        ]
      ]
  end

  def test_select_distinct_parseable
    same_ast? 'select distinct col2 from table1',
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :modifier => Ast::Keyword[:name => 'distinct'],
            :select_list => Ast::Array[
              Ast::Identifier[:name => 'col2']
            ],
            :select_sources => Ast::Identifier[:name => 'table1']
          ]
        ]
      ]
  end

  def test_select_unique_parseable
    same_ast? 'select unique col2 from table1',
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :modifier => Ast::Keyword[:name => 'unique'],
            :select_list => Ast::Array[
              Ast::Identifier[:name => 'col2']
            ],
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
    same_ast? 'select 1 from table1',
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Array[
              Ast::NumberLiteral[:value => '1']
            ],
            :select_sources => Ast::Identifier[:name => 'table1']
          ]
        ]
      ]
  end

  def test_select_literal_nagative_number_column_parseable
    same_ast? 'select -1 from table1',
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Array[
              Ast::NumberLiteral[:value => '-1']
            ],
            :select_sources => Ast::Identifier[:name => 'table1']
          ]
        ]
      ]
  end

  def test_select_literal_float_number_column_parseable
    same_ast? 'select 1.1 from table1',
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Array[
              Ast::NumberLiteral[:value => '1.1']
            ],
            :select_sources => Ast::Identifier[:name => 'table1']
          ]
        ]
      ]
  end

  def test_select_literal_float_nagavite_number_column_parseable
    same_ast? 'select -1.1 from table1',
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Array[
              Ast::NumberLiteral[:value => '-1.1']
            ],
            :select_sources => Ast::Identifier[:name => 'table1']
          ]
        ]
      ]
  end

  def test_select_literal_string_parseable
    same_ast? "select 'adslfael' from table1" ,
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Array[
              Ast::TextLiteral[:value => 'adslfael']
            ],
            :select_sources => Ast::Identifier[:name => 'table1']
          ]
        ]
      ]
  end

  def test_select_asterisk_parseable
    same_ast? "select * from table1",
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Array[
              Ast::Identifier[:name => '*']
            ],
            :select_sources => Ast::Identifier[:name => 'table1']
          ]
        ]
      ]
  end

  def test_select_table_and_asterisk_parseable
    same_ast? "select table1.* from table1",
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Array[
              Ast::Identifier[:name => 'table1.*']
            ],
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
    same_ast? "select * from table1 where col1 = col1",
      Ast::SelectStatement[
        :subquery => Ast::Subquery[
          :query_block => Ast::Base[
            :select_list => Ast::Array[
              Ast::Identifier[:name => '*']
            ],
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
end
