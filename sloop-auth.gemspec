# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "sloop-auth"
  spec.version = "0.1.0"
  spec.summary = "Reusable authentication views and controllers for Stableloop applications"
  spec.authors = ["Stableloop"]
  spec.required_ruby_version = ">= 3.2"
  spec.files = Dir.chdir(__dir__) { Dir["app/**/*", "config/**/*", "lib/**/*", "README.md"].select { |path| File.file?(path) } }
  spec.require_paths = ["lib"]

  spec.add_dependency "devise"
  spec.add_dependency "pundit"
  spec.add_dependency "haml"
  spec.add_dependency "haml-rails"
  spec.add_dependency "html2haml"
  spec.add_dependency "omniauth-google-oauth2"
  spec.add_dependency "omniauth-rails_csrf_protection"
  spec.add_dependency "railties", ">= 8.0"
end
