# TODO: SimpleCov required here...



ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require 'contexts'

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # include the Contexts module for all tests
  include Contexts

  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

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
end
