# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sinatra/swagger-exposer/version'

excluded_patterns = %w[test/ example/ .travis.yml .gitignore]

Gem::Specification.new do |spec|
  spec.name = 'sinatra-swagger-exposer'
  spec.version = Sinatra::SwaggerExposer::VERSION
  spec.authors = ['Julien Kirch', 'Ralf Herzog']
  spec.email = 'ralf.herzog@netcom-kassel.de'

  spec.summary = 'Expose swagger API from your Sinatra app'
  spec.description = 'This Sinatra extension enable you to add metadata to your
 code to expose your API as a Swagger endpoint and to validate and enrich the
 invocation parameters'
  spec.homepage = 'https://github.com/archiloque/sinatra-swagger-exposer'
  spec.license = 'MIT'

  spec.files = `git ls-files -z`
               .split("\x0")
               .reject { |f| excluded_patterns.any? { |ep| f.start_with?(ep) } }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'sinatra', '~> 2.0', '>= 2.0.1'
  spec.add_runtime_dependency 'mime-types', '~> 2.6', '>= 2.6.2'

  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.5'
  spec.add_development_dependency 'rack-test', '~> 0.6.3'
  spec.add_development_dependency 'simplecov', '~> 0'
end
