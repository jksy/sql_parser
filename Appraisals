# Gemfiles for the Oracle connection tests (test/oracle_enhanced-adapter).
# These need Oracle Instant Client (for ruby-oci8) and a reachable Oracle DB;
# the devcontainer (.devcontainer/) provides both.
#
#   bundle exec appraisal install
#   bundle exec rake test:adapter   # switches to gemfiles/adapter_6.gemfile by itself

appraise "adapter-6" do
  group :test do
    gem 'activerecord-oracle_enhanced-adapter', "~> 6.1.6"
    gem 'ruby-oci8', "~> 2.0"
    # Default gems that ActiveSupport 6.1 uses without declaring and that are
    # bundled gems (not loadable without a Gemfile entry) since Ruby 3.4.
    gem 'mutex_m'
    gem 'base64'
    gem 'drb'
    gem 'logger'
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
