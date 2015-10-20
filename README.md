HTML::Pipeline for Nanoc
========================

An [HTML::Pipeline](https://github.com/jch/html-pipeline) filter for [Nanoc](http://nanoc.stoneship.org/).

Installation
------------

Add this your Gemfile:

```ruby
gem 'nanoc-html-pipeline'
```

Usage
-----

In your nanoc Rules file, use an `:html_pipeline` filter to run content through a pipeline.

```ruby
filter :html_pipeline,
  :pipeline => [:markdownfilter, :emojifilter, :syntaxhighlightfilter],
  :asset_root => "http://your-domain.com/where/your/emoji/live"
```

Custom filters are supported; see the tests for an example.
