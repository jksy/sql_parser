require "bundler/gem_tasks"
require 'rake'
require 'rake/testtask'

task :generate => [Rake::FileList.new('lib/sql_parser/oracle.y')]

rule ".y" => ->(f) do
  output_file_name = "#{f.gsub(/\.y$/,'')}.tab.rb"
  cmd = "racc -g -v #{f} -o #{output_file_name}"
  puts cmd
  `#{cmd}`
end

task :test => [:generate]

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/oracle.rb']
  t.verbose = true
end

