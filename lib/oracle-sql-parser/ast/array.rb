# frozen_string_literal: true

require 'forwardable'

module OracleSqlParser::Ast
  class Array < Base
    include Enumerable

    def each(&)
      @ast.each(&)
    end

    def [](index)
      @ast[index]
    end

    def self.[](*values)
      new(*values)
    end

    def map_ast!(&block)
      @ast = @ast.map do |v|
        v.map_ast!(&block) if v.is_a? OracleSqlParser::Ast::Base
        block.call(v)
      end
    end

    # Base#initialize only accepts scalar values, so it is not called here.
    def initialize(*args) # rubocop:disable Lint/MissingSuper
      @ast = args
    end

    def to_sql(options = { separator: ' ' })
      @ast.map do |v|
        if v.respond_to? :to_sql
          v.to_sql
        else
          v.to_s
        end
      end.compact.join(options[:separator])
    end

    def remove_nil_values!
      @ast.delete_if { |v| v.nil? }
      @ast.each { |v| v.remove_nil_values! if v.respond_to? :remove_nil_values! }
      self
    end

    def inspect
      "#<#{self.class.name} [\n" +
        @ast.map { |v| "#{v.inspect}" }.join(",\n").gsub(/^/, '  ') +
        "\n]>\n"
    end
  end
end
