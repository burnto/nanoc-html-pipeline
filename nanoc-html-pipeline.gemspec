# -*- encoding: utf-8 -*-
# $:.push File.expand_path("../lib", __FILE__)

lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require "nanoc-html-pipeline/version"

Gem::Specification.new do |s|
  s.name        = "nanoc-html-pipeline"
  s.version     = NanocHtmlPipeline::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Brent Fitzgerlad"]
  s.email       = ["b@brentfitzgerald.com"]
  s.summary     = "nanoc filter for html-pipeline"
  s.description = ""

  s.rubyforge_project = "nanoc-html-pipeline"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency('nanoc', '>= 3.1.6')
  s.add_runtime_dependency('html-pipeline', '>= 1.0.0')

  s.add_development_dependency('rinku', '~> 1.7.3')
  s.add_development_dependency('github-markdown', '~> 0.6.3')
  s.add_development_dependency('gemoji', '~> 1.5.0')
  s.add_development_dependency('sanitize', '~> 2.0.6')
end
