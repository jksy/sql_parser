require File.expand_path('../test_helper.rb', File.dirname(__FILE__))

module Grammar
  class BaseTest < Test::Unit::TestCase
    include ParseTestable
  end
end
