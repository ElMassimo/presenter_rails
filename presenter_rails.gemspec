Gem::Specification.new do |s|
  s.name = "presenter_rails"
  s.version = '0.0.2'
  s.licenses = ['MIT']
  s.summary = "ViewModels had a baby with helper_method"
  s.description = "Presenter helps you expose view models to your views with a declarative approach."
  s.authors = ["Máximo Mussini"]

  s.email = ["maximomussini@gmail.com"]
  s.extra_rdoc_files = ["README.md"]
  s.files = Dir.glob("{lib}/**/*.rb") + %w(README.md)
  s.homepage = %q{https://github.com/ElMassimo/presenter_rails}

  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>=2.0'
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]

  s.add_runtime_dependency 'activesupport'
  s.add_runtime_dependency 'simple_memoizer'
end
