require "bundler/gem_tasks"
require 'rake'
require 'rake/testtask'

task :gen do
  sh "ruby lib/oracle-sql-parser/grammar/reserved_word_generator.rb"
  tt "lib/oracle-sql-parser/grammar/reserved_word.treetop"
  tt "lib/oracle-sql-parser/grammar/expression.treetop"
  tt "lib/oracle-sql-parser/grammar/condition.treetop"
  tt "lib/oracle-sql-parser/grammar/select.treetop"
  tt "lib/oracle-sql-parser/grammar/update.treetop"
  tt "lib/oracle-sql-parser/grammar/delete.treetop"
  tt "lib/oracle-sql-parser/grammar/insert.treetop"
  tt "lib/oracle-sql-parser/grammar/grammar.treetop"
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
                    'test/grammar/select_test.rb',
                    'test/grammar/update_test.rb',
                    'test/grammar/expression_test.rb',
                    'test/grammar/condition_test.rb',
                    'test/grammar/delete_test.rb',
                    'test/grammar/insert_test.rb',
                    ]
  t.verbose = true
end

