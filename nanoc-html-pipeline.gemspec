# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require "nanoc-html-pipeline/version"

Gem::Specification.new do |s|
  s.name        = "nanoc-html-pipeline"
  s.version     = NanocHtmlPipeline::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Brent Fitzgerlad", "Garen Torikian"]
  s.email       = ["b@brentfitzgerald.com"]
  s.summary     = "nanoc filter for html-pipeline"
  s.description = "An adapter for using html-pipeline as a filter in your nanoc Rules"
  s.homepage    = "https://github.com/burnto/nanoc-html-pipeline"
  s.licenses    = ['MIT']

  s.rubyforge_project = "nanoc-html-pipeline"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency('nanoc', '~> 3.1')
  s.add_runtime_dependency('html-pipeline', '~> 1.0')

  s.add_development_dependency('test-unit', '~> 3.1')
  s.add_development_dependency('rinku', '~> 1.7')
  s.add_development_dependency('github-markdown', '~> 0.6')
  s.add_development_dependency('gemoji', '~> 2.0')
  s.add_development_dependency('sanitize', '~> 2.0')
end
