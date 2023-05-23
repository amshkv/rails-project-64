# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

# NOTE: честно украдено с https://gist.github.com/kerrizor/8bb8f1528c88789c3435
module BulletHelper
  def before_setup
    Bullet.start_request
    super if defined?(super)
  end

  def after_teardown
    super if defined?(super)

    Bullet.perform_out_of_channel_notifications if Bullet.notification?
    Bullet.end_request
  end
end

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    include BulletHelper
  end
end

module ActionDispatch
  class IntegrationTest
    include Devise::Test::IntegrationHelpers
  end
end
