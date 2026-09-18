# Gemfiles for the Oracle connection tests (test/oracle_enhanced-adapter).
# These need Oracle Instant Client (for ruby-oci8) and a reachable Oracle DB.
#
#   bundle exec appraisal install
#   BUNDLE_GEMFILE=gemfiles/adapter_6.gemfile bundle exec rake test:adapter

appraise "adapter-5" do
  group :test do
    gem 'activerecord-oracle_enhanced-adapter', "~> 5.2.0"
    gem 'ruby-oci8', "~> 2.0"
  end
end

appraise "adapter-6" do
  group :test do
    gem 'activerecord-oracle_enhanced-adapter', "~> 6.1.6"
    gem 'ruby-oci8', "~> 2.0"
  end
end

# because raise ORA-01008
# https://app.travis-ci.com/github/jksy/sql_parser/jobs/573226765
# appraise "adapter-7" do
#   group :test do
#     gem 'activerecord-oracle_enhanced-adapter', "~> 7.0.2"
#     gem 'ruby-oci8', "~> 2.0"
#   end
# end
