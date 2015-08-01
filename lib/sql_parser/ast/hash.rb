require 'forwardable'

module SqlParser::Ast
  class Hash < Base
    extend Forwardable
    def_delegator :@ast, :keys, :[]

    def initialize(value)
      raise "only ::Hash instance" unless value.instance_of? ::Hash
      @ast = value
    end

    def remove_nil_values!
      @ast.delete_if{|k, v| v.nil?}
      @ast.each {|k, v| v.remove_nil_values! if v.respond_to? :remove_nil_values!}
      self
    end

    def to_sql
      @ast.map do |k,v|
        if v.respond_to? :to_sql
          v.to_sql
        else
          v.to_s
        end
      end.compact.join(" ")
    end

    def self.[](value)
      self.new(value)
    end

    def method_missing(name, *args)
      return @ast.send(:[], name) if @ast.has_key? name
      raise "no method:#{name}, #{@ast.class} in #{self.class}"
    end
  end
end
