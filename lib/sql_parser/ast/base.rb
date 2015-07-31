def nil.ast
  nil
end

module SqlParser::Ast
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

    def method_missing(name, *args)
      return @ast.send(:[], name) if @ast.has_key? name
      raise "no method:#{name}, #{@ast.class} in #{self.class}"
    end

    def to_ary
      [self]
    end

    def ast
      raise "do not call ast method"
    end

    def self.[](*value)
      if value.length ==0
        self.new(nil)
      else
        self.new(*value)
      end
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
      when SqlParser::Ast::Array
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
