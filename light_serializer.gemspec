# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'light_serializer/version'

Gem::Specification.new do |spec|
  spec.name          = 'light_serializer'
  spec.version       = LightSerializer::VERSION
  spec.authors       = ['Pavel Rodionov', 'Alexander Kotov']
  spec.email         = ['pasha.rod@mail.ru']

  spec.summary       = 'Light and Fast Serializer'
  spec.homepage      = 'https://github.com/krim/light_serializer'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.required_ruby_version = '>= 2.3'
  spec.add_dependency 'oj', '~> 3'
  spec.add_development_dependency 'benchmark-ips'
  spec.add_development_dependency 'bundler', '>= 1.0'
  spec.add_development_dependency 'pry-byebug', '~> 3.9'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'reek', '~> 6.0'
  spec.add_development_dependency 'rspec', '~> 3.9'
  spec.add_development_dependency 'rubocop', '~> 1.27.0'
  spec.add_development_dependency 'rubocop-rspec', '~> 1.38'
  spec.add_development_dependency 'simplecov'
end
