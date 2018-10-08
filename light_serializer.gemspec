# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'light_serializer/version'

Gem::Specification.new do |spec|
  spec.name          = 'light_serializer'
  spec.version       = LightSerializer::VERSION
  spec.authors       = ['krim']
  spec.email         = ['pasha.rod@mail.ru']

  spec.summary       = 'Light and Fast Serializer'
  spec.homepage      = 'https://github.com/krim/light_serializer'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.required_ruby_version = '>= 2.3'
  spec.add_dependency 'activesupport', '~> 4.0'
  spec.add_dependency 'dry-struct', '~> 0.5'
  spec.add_dependency 'dry-types', '~> 0.13.2'
  spec.add_development_dependency 'bundler', '~> 1.0'
  spec.add_development_dependency 'factory_bot', '~> 4.11'
  spec.add_development_dependency 'pry-byebug', '~> 3.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'reek', '~> 5.1'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.59.2'
  spec.add_development_dependency 'rubocop-rspec', '~> 1.30'
end
