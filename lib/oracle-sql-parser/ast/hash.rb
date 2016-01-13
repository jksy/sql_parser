require 'forwardable'

module OracleSqlParser::Ast
  class Hash < Base
    extend Forwardable
    def_delegator :@ast, :keys, :[]

    def initialize(value = {})
      raise "only ::Hash instance #{value.inspect}" unless value.instance_of? ::Hash
      @ast = value
    end

    def remove_nil_values!
      @ast.delete_if{|k, v| v.nil?}
      @ast.each {|k, v| v.remove_nil_values! if v.respond_to? :remove_nil_values!}
      self
    end

    def map_ast!(&block)
      mapped = @ast.class.new
      @ast.each do |k, v|
        if v.is_a? OracleSqlParser::Ast::Base
          v.map_ast!(&block)
        end
        mapped[k] = block.call(v)
      end
      @ast = mapped
    end

    def inspect
      "#<#{self.class.name}\n" + 
      @ast.map{|k,v| "#{k.inspect} => #{v.inspect}"}.join(",\n").gsub(/^/, '  ') +
      "}>\n"
    end

    def to_sql(options = {:separator => ' '})
      @ast.map do |k,v|
        if v.respond_to? :to_sql
          v.to_sql
        else
          v.to_s
        end
      end.compact.join(options[:separator])
    end

    def self.[](value)
      self.new(value)
    end

    def []=(name, value)
      @ast[name] = value
    end

    def method_missing(name, *args)
      return @ast.send(:[], name) if @ast.has_key? name
      raise "no method:#{name}, #{@ast.class} in #{self.class}"
    end
  end
end
