# frozen_string_literal: true

require 'bundler/setup'
require 'pry'
require 'light_serializer'

Dir[File.dirname(__FILE__) + '/shared/contexts/*.rb'].each { |file| require file }
Dir[File.dirname(__FILE__) + '/shared/examples/*.rb'].each { |file| require file }

RSpec.configure do |config|
  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
