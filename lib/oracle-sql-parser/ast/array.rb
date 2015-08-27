require 'forwardable'

module OracleSqlParser::Ast
  class Array < Base
    include Enumerable

    def each(&block)
      @ast.each(&block)
    end

    def [](index)
      @ast[index]
    end

    def self.[](*values)
      self.new(*values)
    end

    def map_ast!(&block)
      @ast = @ast.map do |v|
        if v.is_a? OracleSqlParser::Ast::Base
          v.map_ast!(&block)
        end
        block.call(v)
      end
    end

    def initialize(*args)
      @ast = args
    end

    def to_sql(options = {:separator => ' '})
      @ast.map do |v|
        if v.respond_to? :to_sql
          v.to_sql
        else
          v.to_s
        end
      end.compact.join(options[:separator])
    end

    def remove_nil_values!
      @ast.delete_if{|v| v.nil?}
      @ast.each {|v| v.remove_nil_values! if v.respond_to? :remove_nil_values!}
      self
    end

    def inspect
      "#<#{self.class.name} [\n" + 
      @ast.map{|v| "#{v.inspect}"}.join(",\n").gsub(/^/, '  ') +
      "\n]>\n"
    end
  end
end
