# frozen_string_literal: true

require File.expand_path('../test_helper.rb', File.dirname(__FILE__))
# ActiveSupport 6.1 references Logger without requiring it, which fails with
# concurrent-ruby >= 1.3.5 (it no longer loads logger itself).
require 'logger'
require 'active_record'
require 'active_record/connection_adapters/oracle_enhanced_adapter'

class ::TestEmployee < ActiveRecord::Base
  has_one :company, nil, class_name: 'TestCompany'
end

class ::TestCompany < ActiveRecord::Base
end

module OracleEnhancedAdapter
  class BaseTest < Test::Unit::TestCase
    include ParseTestable

    def self.connection_params
      return @connection_params if defined? @connection_params

      path = File.expand_path('connection_params.yml', File.dirname(__FILE__))
      @connection_params = if File.readable? path
                             YAML.load_file(path)
                           else
                             { 'username' => ENV.fetch('ORACLE_USERNAME', nil),
                               'password' => ENV.fetch('ORACLE_PASSWORD', nil),
                               'host' => ENV.fetch('ORACLE_HOST', nil),
                               'port' => ENV['ORACLE_PORT'].to_i,
                               'database' => ENV.fetch('ORACLE_SID', nil) }
                           end
      @connection_params.merge!('adapter' => 'oracle_enhanced')
      @connection_params
    end

    def self.drop_if_exists(sql)
      @conn.execute sql
    rescue StandardError
      nil # the object does not exist yet
    end

    def self.create_test_table
      @conn = ActiveRecord::Base.connection
      drop_if_exists 'DROP TABLE test_employees'
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
      drop_if_exists 'DROP TABLE test_companies'
      @conn.execute <<-SQL
        CREATE TABLE test_companies (
          id      NUMBER PRIMARY KEY,
          name    VARCHAR2(20)
        )
      SQL

      drop_if_exists 'DROP SEQUENCE test_employees_seq'
      @conn.execute <<-SQL
        CREATE SEQUENCE test_employees_seq  MINVALUE 1
          INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER NOCYCLE
      SQL
      ActiveRecord::Base.clear_cache! if ActiveRecord::Base.respond_to? :clear_cache!
    end
  end
end
