def nil.ast
  nil
end

def nil.to_sql
  nil
end

def nil.until_nil(&block)

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

    def until_nil(&block)
      block.call(self)
    end
  end
end

class String
  def to_sql
    self
  end
end

module OracleSqlParser::Ast
  class Base
    def initialize(arg)
      if arg.instance_of?(Array) || arg.instance_of?(Hash)
        raise "cant assign #{arg.class} Base.new()"
      end
      @ast = arg
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

    def to_sql
      if @ast.respond_to? :to_sql
        @ast.to_sql
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
