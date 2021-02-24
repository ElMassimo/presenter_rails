require File.expand_path("../lib/presenter_rails/version", __FILE__)

Gem::Specification.new do |s|
  s.name = "presenter_rails"
  s.version = PresenterRails::VERSION
  s.authors = ["Máximo Mussini"]
  s.email = ["maximomussini@gmail.com"]
  s.summary = "Expose your view models without using instance variables."
  s.description = "Presenter helps you expose view models to your views with a declarative approach."
  s.homepage = "https://github.com/ElMassimo/presenter_rails"
  s.license = "MIT"
  s.extra_rdoc_files = ["README.md"]
  s.files = Dir.glob("{lib}/**/*.rb") + %w(README.md CHANGELOG.md)
  s.test_files   = Dir.glob("{spec}/**/*.rb")
  s.require_path = "lib"

  s.required_ruby_version = ">= 2.0"

  s.add_dependency "activesupport"

  s.add_development_dependency "actionmailer"
  s.add_development_dependency "simplecov", "< 0.18"
  s.add_development_dependency "railties", ">= 4.0"
  s.add_development_dependency "rspec-given", "~> 3.0"
  s.add_development_dependency "rspec-rails", "~> 3.0"
end
