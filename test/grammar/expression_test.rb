require File.expand_path('base_test.rb', File.dirname(__FILE__))

module Grammar
  class ExpressionTest < BaseTest
    def test_simple_expression_rownum_parseable
      same_ast? "select rownum from dual",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Keyword[:name => 'rownum']
              ],
              :select_sources => Ast::TableReference[
                :table_name => Ast::Identifier[:name => 'dual']
              ]
            ],
          ],
        ]
    end
  
    def test_simple_expression_text_literal_parseable
      same_ast? "select 'asdlfjasldfja' from dual",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::TextLiteral[:value => 'asdlfjasldfja']
              ],
              :select_sources => Ast::TableReference[
                :table_name => Ast::Identifier[:name => 'dual']
              ]
            ],
          ],
        ]
    end
  
    def test_simple_expression_number_literal_parseable
      same_ast? "select 13123 from dual",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::NumberLiteral[:value => '13123']
              ],
              :select_sources => Ast::TableReference[
                :table_name => Ast::Identifier[:name => 'dual']
              ]
            ],
          ],
        ]
    end
  
    def test_simple_expression_sequence_nextval_parseable
      same_ast? "select sequence_name.nextval from dual",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:value => 'sequence_name.nextval']
              ],
              :select_sources => Ast::TableReference[
                :table_name => Ast::Identifier[:name => 'dual']
              ]
            ],
          ],
        ]
    end
  
    def test_simple_expression_sequence_currval_parseable
      same_ast? "select sequence_name.currval from dual",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:value => 'sequence_name.currval']
              ],
              :select_sources => Ast::TableReference[
                :table_name => Ast::Identifier[:name => 'dual']
              ]
            ],
          ],
        ]
    end
  
    def test_simple_expression_null_parseable
      same_ast? "select null from dual",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Keyword[:name => 'null']
              ],
              :select_sources => Ast::TableReference[
                :table_name => Ast::Identifier[:name => 'dual']
              ]
            ],
          ],
        ]
    end
  
    def test_simple_expression_column_by_schema_table_column_parseable
      same_ast? "select schema1.table1.column1 from dual",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => 'schema1.table1.column1']
              ],
              :select_sources => Ast::TableReference[
                :table_name => Ast::Identifier[:name => 'dual']
              ]
            ],
          ],
        ]
    end
  
    def test_simple_expression_column_by_table_column_parseable
      same_ast? "select table1.column1 from dual",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => 'table1.column1']
              ],
              :select_sources => Ast::TableReference[
                :table_name => Ast::Identifier[:name => 'dual']
              ]
            ],
          ],
        ]
    end
  
    def test_simple_expression_column_by_column_parseable
      same_ast? "select column1 from dual",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => 'column1']
              ],
              :select_sources => Ast::TableReference[
                :table_name => Ast::Identifier[:name => 'dual']
              ]
            ],
          ],
        ]
    end
  
    def test_simple_expression_column_by_rowid_parseable
      same_ast? "select rowid from dual",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::Identifier[:name => 'rowid']
              ],
              :select_sources => Ast::TableReference[
                :table_name => Ast::Identifier[:name => 'dual']
              ]
            ],
          ],
        ]
    end
  
    def test_simple_case_expression_parseable
      same_ast? "select case credit_limit when 100 then 'low' when 5000 then 'high' end from customers",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SimpleCaseExpression[
                  :condition => Ast::Identifier[:name => 'credit_limit'],
                  :when_clauses => Ast::Array[
                    Ast::Hash[
                      :when_expr => Ast::NumberLiteral[:value=>'100'],
                      :return_expr => Ast::TextLiteral[:value=>'low']
                    ],
                    Ast::Hash[
                      :when_expr => Ast::NumberLiteral[:value=>'5000'],
                      :return_expr => Ast::TextLiteral[:value=>'high']
                    ]
                  ]
                ]
              ],
              :select_sources => Ast::TableReference[
                :table_name => Ast::Identifier[:name => 'customers']
              ]
            ]
          ]
        ]
    end
  
    def test_simple_case_expression_else_parseable
      same_ast? "select case credit_limit when 100 then 'low' when 5000 then 'high' else 'medium' end from customers",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SimpleCaseExpression[
                  :condition => Ast::Identifier[:name => 'credit_limit'],
                  :when_clauses => Ast::Array[
                    Ast::Hash[
                      :when_expr => Ast::NumberLiteral[:value=>'100'],
                      :return_expr => Ast::TextLiteral[:value=>'low']
                    ],
                    Ast::Hash[
                      :when_expr => Ast::NumberLiteral[:value=>'5000'],
                      :return_expr => Ast::TextLiteral[:value=>'high']
                    ]
                  ],
                  :else_clause => Ast::TextLiteral[:value => 'medium']
                ]
              ],
              :select_sources => Ast::TableReference[
                :table_name => Ast::Identifier[:name => 'customers']
              ]
            ]
          ]
        ]
    end
  
    def test_searched_case_expression_else_parseable
      same_ast? "select case when salary > 2000 then salary else 2001 end from customers",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::SearchedCaseExpression[
                  :when_condition => Ast::SimpleComparisionCondition[
                    :left => Ast::Identifier[:name => 'salary'],
                    :op => '>',
                    :right => Ast::NumberLiteral[:value => '2000']
                  ],
                  :return_expr => Ast::Identifier[:name=>'salary'],
                  :else_clause => Ast::NumberLiteral[:value => '2001']
                ]
              ],
              :select_sources => Ast::TableReference[
                :table_name => Ast::Identifier[:name => 'customers']
              ]
            ]
          ]
        ]
    end
  
    def test_function_expression_no_args_parseable
      same_ast? "select func() from dual",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::FunctionExpressoin[
                  :name => Ast::Identifier[:name =>'func'],
                ]
              ],
              :select_sources => Ast::TableReference[
                :table_name => Ast::Identifier[:name => 'dual']
              ]
            ],
          ]
        ]
    end
  
    def test_function_expression_one_args_parseable
      same_ast? "select one_arg_function(col1) from customers",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::FunctionExpressoin[
                  :name => Ast::Identifier[:name => 'one_arg_function'],
                  :args => Ast::Array[
                    Ast::Identifier[:name => 'col1']
                  ],
                ]
              ],
              :select_sources => Ast::TableReference[
                :table_name => Ast::Identifier[:name => 'customers']
              ]
            ],
          ]
        ]
    end
  
    def test_function_expression_two_args_parseable
      same_ast? "select two_args_function(1, '0') from dual",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::FunctionExpressoin[
                  :name => Ast::Identifier[:name => 'two_args_function'],
                  :args => Ast::Array[
                    Ast::NumberLiteral[:value => '1'],
                    Ast::TextLiteral[:value => '0'],
                  ],
                ]
              ],
              :select_sources => Ast::TableReference[
                :table_name => Ast::Identifier[:name => 'dual']
              ] 
            ],
          ]
        ]
    end
  
    def test_function_expression_package_name_parseable
      same_ast? "select package_name.procedure_name(col1) from customers",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::FunctionExpressoin[
                  :name => Ast::Identifier[:name => 'package_name.procedure_name'],
                  :args => Ast::Array[
                    Ast::Identifier[:name => 'col1'],
                  ],
                ]
              ],
              :select_sources => Ast::TableReference[
                :table_name => Ast::Identifier[:name => 'customers']
              ]
            ],
          ]
        ]
    end
  
    def test_function_expression_function_in_args_parseable
      same_ast? "select to_date(to_char(sysdate, 'yyyy/mm/dd hh24:mi:ss')) from dual",
        Ast::SelectStatement[
          :subquery => Ast::Subquery[
            :query_block => Ast::QueryBlock[
              :select_list => Ast::Array[
                Ast::FunctionExpressoin[
                  :name => Ast::Identifier[:name => 'to_date'],
                  :args => Ast::Array[
                    Ast::FunctionExpressoin[
                      :name => Ast::Identifier[:name => 'to_char'],
                      :args => Ast::Array[
                        Ast::Keyword[:name => 'sysdate'],
                        Ast::TextLiteral[:value => 'yyyy/mm/dd hh24:mi:ss']
                      ]
                    ]
                  ],
                ]
              ],
              :select_sources => Ast::TableReference[
                :table_name =>Ast::Identifier[:name => 'dual']
              ]
            ],
          ]
        ]
    end
  end
end
