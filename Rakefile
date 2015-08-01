require "bundler/gem_tasks"
require 'rake'
require 'rake/testtask'

task :gen do
  sh "ruby lib/sql_parser/oracle/reserved_word_generator.rb"
  tt "lib/sql_parser/oracle/reserved_word.treetop"
  tt "lib/sql_parser/oracle/expression.treetop"
  tt "lib/sql_parser/oracle/condition.treetop"
  tt "lib/sql_parser/oracle/select.treetop"
  tt "lib/sql_parser/oracle/update.treetop"
  tt "lib/sql_parser/oracle/delete.treetop"
  tt "lib/sql_parser/oracle/insert.treetop"
  tt "lib/sql_parser/oracle/oracle.treetop"
end

def tt(f, force = false)
  output_file_name = "#{f.gsub(/\.treetop$/,'')}.rb"

  force = true unless File.exists?(output_file_name)
  if force || File::Stat.new(f).mtime >= File::Stat.new(output_file_name).mtime
    sh "tt #{f} -f -o #{output_file_name}"
  end
end


#task :test => [:generate]

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList[
                    'test/oracle/select_test.rb',
                    'test/oracle/update_test.rb',
                    'test/oracle/expression_test.rb',
                    'test/oracle/condition_test.rb',
                    'test/oracle/delete_test.rb',
                    'test/oracle/insert_test.rb',
                    'test/ast/select_statement_test.rb',
                    ]
  t.verbose = true
end

