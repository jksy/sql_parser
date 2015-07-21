class Base < Test::Unit::TestCase
  def parse_successful(query)
    generate_ast(query)
  end

  def same_ast?(query, expect)
    actual = generate_ast(query)
    assert_ast_equal(expect, actual)
  end
end
