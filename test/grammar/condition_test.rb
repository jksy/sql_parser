require File.expand_path('base_test.rb', File.dirname(__FILE__))

module Grammar
  class ConditionTest < BaseTest
    def test_select_where_parseable
      same_ast? "select * from table1 where col1 = col1",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::TableReference[
                :table_name => Ast::Identifier[:name => 'table1']
              ],
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
      same_ast? "select * from table1 where col1 = 'abc'",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::TableReference[
                :table_name => Ast::Identifier[:name => 'table1']
              ],
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
      same_ast? "select * from table1 where col1 = -1",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::TableReference[
                :table_name => Ast::Identifier[:name => 'table1']
              ],
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
      same_ast? "select * from table1 where col1 != 1",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::TableReference[
                :table_name => Ast::Identifier[:name => 'table1']
              ],
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
      same_ast? "select * from table1 where col1 ^= 1",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::TableReference[
                :table_name => Ast::Identifier[:name => 'table1']
              ],
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
      same_ast? "select * from table1 where col1 <> 1",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::TableReference[
                :table_name => Ast::Identifier[:name => 'table1']
              ],
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
      same_ast? "select * from table1 where col1 <= 1",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::TableReference[
                :table_name =>Ast::Identifier[:name => 'table1']
              ],
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
      same_ast? "select * from table1 where col1 >= 1",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::TableReference[
                :table_name => Ast::Identifier[:name => 'table1']
              ],
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
      same_ast? "select * from table1 where col1 = col2 and col3 = col4",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::TableReference[
                :table_name => Ast::Identifier[:name => 'table1']
              ],
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
      same_ast? "select * from table1 where col1 = col2 or col3 = col4",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::TableReference[
                :table_name => Ast::Identifier[:name => 'table1']
              ],
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
      same_ast? "select * from table1 where col1 like 'abc%'",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::TableReference[
                :table_name => Ast::Identifier[:name => 'table1']
              ],
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
      same_ast? "select * from table1 where col1 likec 'abc%'",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::TableReference[
                :table_name => Ast::Identifier[:name => 'table1']
              ],
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
      same_ast? "select * from table1 where col1 like2 'abc%'",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::TableReference[
                :table_name => Ast::Identifier[:name => 'table1']
              ],
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
      same_ast? "select * from table1 where col1 like4 'abc%'",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::TableReference[
                :table_name => Ast::Identifier[:name => 'table1']
              ],
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
      same_ast? "select * from table1 where col1 not like 'abc%'",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::TableReference[
                :table_name => Ast::Identifier[:name => 'table1']
              ],
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
      same_ast? "select * from table1 where col1 like 'abc%' escape '@'",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::TableReference[
                :table_name => Ast::Identifier[:name => 'table1']
              ],
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
      same_ast? "select * from table1 where regexp_like(col1,  '^Ste(v|ph)en$')",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::TableReference[
                :table_name => Ast::Identifier[:name => 'table1']
              ],
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
      same_ast? "select * from table1 where col1 is null",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::TableReference[
                :table_name => Ast::Identifier[:name => 'table1']
              ],
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
      same_ast? "select * from table1 where col1 is not null",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::TableReference[
                :table_name => Ast::Identifier[:name => 'table1']
              ],
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
      same_ast? "select * from table1 where (col1 = col2)",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::TableReference[
                :table_name => Ast::Identifier[:name => 'table1']
              ],
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
      same_ast? "select * from table1 where not col1 = col2",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::TableReference[
                :table_name => Ast::Identifier[:name => 'table1']
              ],
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
      same_ast? "select * from table1 where col1 between col2 and col3",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::TableReference[
                :table_name => Ast::Identifier[:name => 'table1']
              ],
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
      same_ast? "select * from table1 where col1 not between col2 and col3",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::TableReference[
                :table_name => Ast::Identifier[:name => 'table1']
              ],
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
      same_ast? "select * from table1 where col1 between 1 and 100",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::TableReference[
                :table_name => Ast::Identifier[:name => 'table1']
              ],
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
      same_ast? "select * from table1 where col1 between 'a' and 'z'",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::TableReference[
                :table_name => Ast::Identifier[:name => 'table1']
              ],
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
      same_ast? "select * from table1 where exists (select 1 from table2)",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::TableReference[
                :table_name => Ast::Identifier[:name => 'table1']
              ],
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
      same_ast? "select * from table1 where not exists (select 1 from table2)",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::TableReference[
                :table_name => Ast::Identifier[:name => 'table1']
              ],
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
      same_ast? "select * from table1 where col1 in (1)",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::TableReference[
                :table_name => Ast::Identifier[:name => 'table1']
              ],
              :where_clause => Ast::WhereClause[
                :condition => Ast::InCondition[
                  :target => Ast::Identifier[:name => 'col1'],
                  :values => Ast::Array[
                    Ast::NumberLiteral[:value => '1']
                  ]
                ]
              ]
            ]
          ]
        ]
    end
  
    def test_select_where_not_in_expr_condition_parseable
      same_ast? "select * from table1 where col1 not in (1)" ,
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::TableReference[
                :table_name => Ast::Identifier[:name => 'table1']
              ],
              :where_clause => Ast::WhereClause[
                :condition => Ast::InCondition[
                  :target => Ast::Identifier[:name => 'col1'],
                  :not => Ast::Keyword[:name => 'not'],
                  :values => Ast::Array[
                    Ast::NumberLiteral[:value => '1']
                  ]
                ]
              ]
            ]
          ]
        ]
    end
  
    def test_select_where_in_subquery_condition_parseable
      same_ast? "select * from table1 where col1 in (select * from table2)",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::TableReference[
                :table_name =>Ast::Identifier[:name => 'table1']
              ],
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
      same_ast? "select * from table1 where col1 not in (select * from table2)",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => '*']
              ],
              :select_sources => Ast::TableReference[
                :table_name => Ast::Identifier[:name => 'table1']
              ],
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
  end
end
