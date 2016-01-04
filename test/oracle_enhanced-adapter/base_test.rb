require File.expand_path('../test_helper.rb', File.dirname(__FILE__))
require 'active_record'
require 'active_record/connection_adapters/oracle_enhanced_adapter'

class ::TestEmployee < ActiveRecord::Base
end

module OracleEnhancedAdapter
  class BaseTest < Test::Unit::TestCase

    include ParseTestable

    def self.connection_params
      return @connection_params if @connection_params
  
      path = File.expand_path('connection_params.yml', File.dirname(__FILE__))
      if File.readable? path
        @connection_params = YAML::load_file(path)
      else
        @connection_params = {'username' => nil,
                              'password' => nil,
                              'host' => nil,
                              'database' => nil}
      end
      @connection_params.merge!(:adapter => 'oracle_enhanced')
      @connection_params
    end

    def self.create_test_table
      @conn = ActiveRecord::Base.connection
      @conn.execute "DROP TABLE test_employees" rescue nil
      @conn.execute <<-SQL
        CREATE TABLE test_employees (
          id            NUMBER PRIMARY KEY,
          first_name    VARCHAR2(20),
          last_name     VARCHAR2(25),
          email         VARCHAR2(25),
          phone_number  VARCHAR2(20),
          hire_date     DATE,
          job_id        NUMBER,
          salary        NUMBER,
          commission_pct  NUMBER(2,2),
          manager_id    NUMBER(6),
          department_id NUMBER(4,0),
          created_at    DATE
        )
      SQL
      @conn.execute "DROP SEQUENCE test_employees_seq" rescue nil
      @conn.execute <<-SQL
        CREATE SEQUENCE test_employees_seq  MINVALUE 1
          INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER NOCYCLE
      SQL
      ActiveRecord::Base.clear_cache! if ActiveRecord::Base.respond_to? "clear_cache!".to_sym
    end
  end
end
