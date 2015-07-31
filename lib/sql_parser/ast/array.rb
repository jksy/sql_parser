require 'forwardable'

module SqlParser::Ast
  class Array < Base
    extend Forwardable
    def_delegator :@ast, :each, :[]

    def initialize(*args)
      @ast = args
    end

    def remove_nil_values!
      @ast.delete_if{|v| v.nil?}
      @ast.each {|v| v.remove_nil_values! if v.respond_to? :remove_nil_values!}
      self
    end

    def self.[](*values)
      self.new(*values)
    end
  end
end
