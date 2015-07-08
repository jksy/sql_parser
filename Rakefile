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
  tt "lib/sql_parser/oracle/oracle.treetop"
  tt "lib/sql_parser/oracle/delete.treetop"
end

def tt(f)
  output_file_name = "#{f.gsub(/\.treetop$/,'')}.rb"
  cmd = "tt #{f} -f -o #{output_file_name}"
  sh cmd
end


#task :test => [:generate]

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/oracle.rb']
  t.verbose = true
end

