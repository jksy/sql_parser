# Gemfiles for the Oracle connection tests (test/oracle_enhanced-adapter).
# These need Oracle Instant Client (for ruby-oci8) and a reachable Oracle DB;
# the devcontainer (.devcontainer/) provides both.
#
#   bundle exec appraisal install
#   bundle exec rake test:adapter                 # switches to gemfiles/adapter_6.gemfile by itself
#   bundle exec appraisal rake test:adapter:run   # every ActiveRecord version below

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

appraise "adapter-7" do
  group :test do
    gem 'activerecord-oracle_enhanced-adapter', "~> 7.2.0"
    gem 'ruby-oci8', "~> 2.0"
  end
end

appraise "adapter-8" do
  group :test do
    gem 'activerecord-oracle_enhanced-adapter', "~> 8.1.0"
    gem 'ruby-oci8', "~> 2.0"
  end
end
