# TODO: SimpleCov required here...



ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "minitest"
require 'minitest/rails'
require 'minitest/reporters'
require 'minitest_extensions'
require 'contexts'
require 'shoulda/matchers'

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # include the Contexts module for all tests
  include Contexts

  # Run tests in parallel with specified workers
  # parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  # Prof. H's helper method to increase readability
  def deny(condition, msg="")
    assert !condition, msg
  end

  # Enable shoulda-matchers in unit tests
  Shoulda::Matchers.configure do |config|
    config.integrate do |with|
      with.test_framework :minitest
      with.library :rails
    end
  end

  # Spruce up minitest results...
  Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new]

end
