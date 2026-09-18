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
    File.unlink file if File.exist? file
  end
end

namespace :test do
  Rake::TestTask.new(:unit) do |t|
    t.description = "run parser tests (no Oracle required)"
    t.libs << "test"
    t.test_files = FileList[
                      'test/grammar/*_test.rb',
                      'test/ast/*_test.rb'
                      ]
    t.verbose = true
  end

  Rake::TestTask.new(:adapter) do |t|
    t.description = "run Oracle connection tests (needs an appraisal gemfile and an Oracle DB)"
    t.libs << "test"
    t.test_files = FileList['test/oracle_enhanced-adapter/select_test.rb']
    t.verbose = true
  end
end

desc "run all tests (test:unit and test:adapter)"
task :test => ['test:unit', 'test:adapter']

task :default => 'test:unit'


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
  force = true unless File.exist?(output)
  if force || File::Stat.new(src).mtime >= File::Stat.new(output).mtime
    yield
  end
end

