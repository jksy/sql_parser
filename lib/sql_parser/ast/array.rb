require 'forwardable'

module SqlParser::Ast
  class Array < Base
    extend Forwardable
    def_delegator :@ast, :each, :[]
    def self.[](*values)
      self.new(*values)
    end

    def initialize(*args)
      @ast = args
    end

    def to_sql
      @ast.map do |v|
        if v.respond_to? :to_sql
          v.to_sql
        else
          v.to_s
        end
      end.compact.join(" ")
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
