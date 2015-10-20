HTML::Pipeline for Nanoc
========================

An [HTML::Pipeline](https://github.com/jch/html-pipeline) filter for [Nanoc](http://nanoc.stoneship.org/).

Status
------

Still under development.

Installation
------------

HTML::Pipeline requires ICU.

```bash
brew install icu4c
bundle config build.charlock_holmes --with-icu-dir=/usr/local/opt/icu4c
```

In the near future, you'll be able to add this your Gemfile:

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
