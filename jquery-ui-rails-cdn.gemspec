# -*- encoding: utf-8 -*-
require File.expand_path('../lib/jquery-ui-rails-cdn/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Mikhail Pobolovets']
  gem.email         = ['styx.mp@gmail.com']
  gem.description   = %q{Add CDN support to jquery-ui-rails}
  gem.summary       = %q{Add CDN support to jquery-ui-rails with fallback if CDN is not available}
  gem.homepage      = 'https://github.com/styx/jquery-ui-rails-cdn'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'jquery-ui-rails-cdn'
  gem.require_paths = ['lib']
  gem.version       = Jquery::Ui::Rails::Cdn::VERSION

  gem.add_runtime_dependency 'jquery-ui-rails', '>= 4.1.0'

  gem.add_development_dependency 'bundler', '~> 1.3'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'coveralls'
  gem.add_development_dependency 'fuubar'
  gem.add_development_dependency 'pry'
end
