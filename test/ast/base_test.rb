require File.expand_path('../test_helper.rb', File.dirname(__FILE__))

module Ast
  class BaseExtension < Test::Unit::TestCase
    def test_nil_ast
      assert_equal(nil.ast, nil)
    end

    def test_nil_to_sql
      assert_equal(nil.to_sql, nil)
    end

    def test_nil_duplicable?
      assert_equal(nil.duplicable?, false)
    end

    def test_symbol_duplicable?
      assert_equal(:symbol.duplicable?, false)
    end

    def test_numeric_duplicable?
      assert_equal(300.duplicable?, false)
    end

    def test_object_duplicable?
      assert_equal(Object.new.duplicable?, true)
    end

    def test_string_to_sql
      assert_equal('test'.to_sql, 'test')
    end
  end
end
