
def nil.ast
  nil
end

def nil.to_sql(options = {})
  nil
end

def nil.duplicable?
  false
end

def true.duplicable?
  false
end

def false.duplicable?
  false
end

class Symbol
  def duplicable?
    false
  end
end

class Numeric
  def duplicable?
    false
  end
end

unless Object.respond_to? :try
  class Object
    def try(name, *args)
      if respond_to? name
        send(name, *args)
      else
        nil
      end
    end

    def duplicable?
      true
    end
  end
end

class String
  def to_sql(options ={})
    self
  end
end

module OracleSqlParser::Ast
  class Base
    include OracleSqlParser::Util::Parameternizable
    def initialize(arg)
      if arg.instance_of?(Array) || arg.instance_of?(Hash)
        raise "cant assign #{arg.class} Base.new()"
      end
      @ast = arg
    end

    def initialize_copy(original)
      if @ast.nil?
        self.class.new
      else
        self.class.new(original.instance_variable_get(:@ast).dup)
      end
    end

    def self.deep_dup(original)
      if original.is_a? OracleSqlParser::Ast::Base
        original.deep_dup
      elsif original.is_a? ::Hash
        ::Hash[ original.map {|k, v| [k, deep_dup(v)]} ]
      elsif original.is_a? ::Array
        original.map {|v| deep_dup(v)}
      elsif original.duplicable?
        original.dup
      else
        original
      end
    end

    def deep_dup
      copy = self.class.new
      original_ast = self.instance_variable_get(:@ast)
      copy_ast = self.class.deep_dup(original_ast)
      copy.instance_variable_set(:@ast, copy_ast)
      copy
    end

    def map_ast(&block)
      duplicated = self.deep_dup
      duplicated.map_ast!(&block)
      duplicated
    end

    def map_ast!(&block)
      if @ast.is_a? OracleSqlParser::Ast::Base
        @ast.map_ast!(&block)
      end
      @ast = block.call(@ast)
    end

    def remove_nil_values!
      @ast.remove_nil_values! if @ast.respond_to? :remove_nil_values!
      self
    end

    def inspect
      "#<#{self.class.name} #{@ast.inspect}>"
    end
    alias :to_s :inspect

    def ast
      raise "do not call ast method"
    end

    def to_sql(options ={})
      if @ast.respond_to? :to_sql
        @ast.to_sql(options)
      else
        @ast.to_s
      end
    end

    def self.[](value)
      self.new(value)
    end

    def self.find_different_value(left, right, &block)
      if left.class != right.class
        block.call(left, right) if block_given?
        return true
      end

      result = false
      case left
      when Base
        result ||= self.find_different_value(
                      left.instance_variable_get(:@ast),
                      right.instance_variable_get(:@ast),
                      &block)
      when Hash
        (left.keys + right.keys).uniq.each do |key|
          result ||= self.find_different_value(left[key], right[key], &block)
        end
      when OracleSqlParser::Ast::Array
        if left.size == right.size
          left.each_with_index do |value, index|
            result ||= self.find_different_value(value, right[index], &block)
          end
        else
          block.call(left, right) if block_given?
          result = true
        end
      else
        if left != right
          block.call(left, right) if block_given?
          result = true
        end
      end
      result
    end

    def ==(value)
      self.class.find_different_value(self, value) != true
    end
  end
end
