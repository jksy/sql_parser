require "bundler/gem_tasks"
require 'rake'
require 'rake/testtask'

GRAMMAR_FILES = FileList['lib/oracle-sql-parser/grammar/**/*.treetop']

desc "generate parser files"
task :gen do
  generate_parser_files(false)
end

desc "generate parser files(force)"
task :gen_force do
  generate_parser_files(true)
end

desc "clean files"
task :clean do
  GRAMMAR_FILES.each do |f|
    file = "#{f.gsub(/\.treetop$/,'')}.rb"
    File.unlink file if File.exists? file
  end
end

desc "build gem for current versioin"
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
                    'test/ast/text_literal_test.rb',
#                    'test/oracle_enhanced-adapter/select_test.rb'
                    ]
  t.verbose = true
end


def generate_parser_files(force = false)
  word_generator = "lib/oracle-sql-parser/grammar/reserved_word_generator.rb"
  output = "lib/oracle-sql-parser/grammar/reserved_word.treetop"
  do_if_changed(word_generator, output, force) do
    sh "ruby #{word_generator}"
  end

  GRAMMAR_FILES.each do |f|
    tt(f, force)
  end
end

def tt(f, force = false)
  output = "#{f.gsub(/\.treetop$/,'')}.rb"

  do_if_changed(f, output, force) do
    sh "tt #{f} -f -o #{output}"
  end
end

def do_if_changed(src, output, force = false, &block)
  force = true unless File.exists?(output)
  if force || File::Stat.new(src).mtime >= File::Stat.new(output).mtime
    yield
  end
end

