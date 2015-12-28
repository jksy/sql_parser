require "bundler/gem_tasks"
require 'rake'
require 'rake/testtask'

GRAMMAR_FILES = FileList['lib/oracle-sql-parser/grammar/*.treetop']

task :gen do
  generate_parser_files(false)
end

task :gen_force do
  generate_parser_files(true)
end

task :clean do
  GRAMMAR_FILES.each do |f|
    file = "#{f.gsub(/\.treetop$/,'')}.rb"
    File.unlink file if File.exists? file
  end
end

task :build_gem => [:gen_force] do
  sh 'gem build oracle-sql-parser.gemspec'
end

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList[
                    'test/grammar/select_test.rb',
                    'test/grammar/update_test.rb',
                    'test/grammar/expression_test.rb',
                    'test/grammar/condition_test.rb',
                    'test/grammar/delete_test.rb',
                    'test/grammar/insert_test.rb',
                    'test/ast/replace_literal_test.rb',
                    'test/ast/number_literal_test.rb',
                    'test/ast/text_literal_test.rb',
                    ]
  t.verbose = true
end


def generate_parser_files(force = false)
  sh "ruby lib/oracle-sql-parser/grammar/reserved_word_generator.rb"
  GRAMMAR_FILES.each do |f|
    tt(f, force)
  end
end

def tt(f, force = false)
  output_file_name = "#{f.gsub(/\.treetop$/,'')}.rb"

  force = true unless File.exists?(output_file_name)
  if force || File::Stat.new(f).mtime >= File::Stat.new(output_file_name).mtime
    sh "tt #{f} -f -o #{output_file_name}"
  end
end

