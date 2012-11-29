require 'bundler/setup'
require 'test/unit'
require 'active_support/core_ext/object/try'
require "nanoc-html-pipeline"

URL = "http://www.ruby-lang.org/"
CONTEXT = {
  :asset_root => "http://foo.com/icons",
  :base_url   => "http://foo.com"
}

class NanocHtmlPipelineTest < Test::Unit::TestCase

  def test_single_filter
    input = "<p>a link is #{URL}</p>"
    assert_equal HTML::Pipeline::AutolinkFilter.to_html(input),
      NanocHtmlPipeline.new.run(input, :pipeline => [:autolinkfilter])
  end

  def test_filter_class
    input = "<p>a link is #{URL}</p>"
    assert_equal NanocHtmlPipeline.new.run(input, :pipeline => [HTML::Pipeline::AutolinkFilter]),
      NanocHtmlPipeline.new.run(input, :pipeline => [:autolinkfilter])
  end

  def test_params
    asset_root = "https://a248.e.akamai.net/assets.github.com/images/icons/"
    expected = "<p>an emoji <img class=\"emoji\" title=\":smile:\" alt=\":smile:\" src=\"#{asset_root}emoji/smile.png\" height=\"20\" width=\"20\" align=\"absmiddle\"></p>"
    assert_equal expected,
      NanocHtmlPipeline.new.run("<p>an emoji :smile:</p>", :pipeline => [:emojifilter], :asset_root => asset_root)
  end

  def test_multiple_filters
    assert_equal "<p>a link is <a href=\"#{URL}\">#{URL}</a></p>",
      NanocHtmlPipeline.new.run("a link is #{URL}", :pipeline => [:markdownfilter, :autolinkfilter])
  end

  def test_pipeline
    input = "a link is #{URL}"

    filters = [
      HTML::Pipeline::MarkdownFilter,
      HTML::Pipeline::SanitizationFilter,
      HTML::Pipeline::CamoFilter,
      HTML::Pipeline::ImageMaxWidthFilter,
      HTML::Pipeline::HttpsFilter,
      HTML::Pipeline::MentionFilter,
      HTML::Pipeline::EmojiFilter,
      HTML::Pipeline::SyntaxHighlightFilter
    ]
    pipeline = HTML::Pipeline.new(filters, CONTEXT.merge(:gfm => true))
    assert_equal pipeline.to_html(input),
      NanocHtmlPipeline.new.run(input, :pipeline => filters)
  end



end
