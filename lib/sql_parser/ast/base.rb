def nil.ast
  nil
end

module SqlParser::Ast
  class Base
    def initialize(args)
      if args == nil
        @ast = {}
      else
        @ast = args
      end
      @diff = nil
    end

    def remove_nil_values!
      case @ast
      when Hash
        @ast.delete_if{|key, value| value == nil}
      when Base
        @ast.remove_nil_values!
      end
      self
    end

    def inspect
      r = []
      case @ast
      when nil
        r << "#<#{self.class.name} nil>"
      when Hash, Array
        r << "#<#{self.class.name} #{@ast.inspect}>"
      when Array
        r << "#<#{self.class.name} #{@ast.inspect}>"
      else
        r << "#<#{self.class.name} #{@ast.inspect}>"
      end
      r.join("\n")
    end

    def method_missing(name, *args)
      return @ast.send(:[], name) if @ast.has_key? name
      raise "no method:#{name}, #{@ast.class} in #{self.class}"
    end

    def to_s
      "<#{self.class} #{@ast.inspect}>"
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
      when Array
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
