# frozen_string_literal: true

require 'bundler/setup'
require 'pry'
require 'light_serializer'

Dir["#{__dir__}/shared/contexts/*.rb"].sort.each { |file| require file }
Dir["#{__dir__}/shared/examples/*.rb"].sort.each { |file| require file }

if ENV['WITH_COVERAGE']
  require 'simplecov'

  SimpleCov.start do
    add_filter 'spec/*'
  end
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.order = :random
end
