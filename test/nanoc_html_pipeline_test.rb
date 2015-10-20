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
      NanocHtmlPipeline::Filter.new.run(input, :pipeline => [:autolinkfilter])
  end

  def test_filter_class
    input = "<p>a link is #{URL}</p>"
    assert_equal NanocHtmlPipeline::Filter.new.run(input, :pipeline => [HTML::Pipeline::AutolinkFilter]),
      NanocHtmlPipeline::Filter.new.run(input, :pipeline => [:autolinkfilter])
  end

  def test_params
    asset_root = "https://a248.e.akamai.net/assets.github.com/images/icons/"
    expected = "<p>an emoji <img class=\"emoji\" title=\":smile:\" alt=\":smile:\" src=\"#{asset_root}emoji/unicode/1f604.png\" height=\"20\" width=\"20\" align=\"absmiddle\"></p>"
    assert_equal expected,
      NanocHtmlPipeline::Filter.new.run("<p>an emoji :smile:</p>", :pipeline => [:emojifilter], :asset_root => asset_root)
  end

  def test_multiple_filters
    assert_equal "<p>a link is <a href=\"#{URL}\">#{URL}</a></p>",
      NanocHtmlPipeline::Filter.new.run("a link is #{URL}", :pipeline => [:markdownfilter, :autolinkfilter])
  end

  def test_pipeline
    input = "a link is #{URL}"

    filters = [
      HTML::Pipeline::MarkdownFilter,
      HTML::Pipeline::SanitizationFilter,
      HTML::Pipeline::ImageMaxWidthFilter,
      HTML::Pipeline::MentionFilter
    ]
    pipeline = HTML::Pipeline.new(filters, CONTEXT.merge(:gfm => true))
    assert_equal pipeline.to_html(input),
      NanocHtmlPipeline::Filter.new.run(input, :pipeline => filters)
  end

  def test_work_for_custom_filters
    require 'support/new_pipeline'
    input = "\n {{#tip}}\n **Tip**: Wow! \n {{/tip}}"

    filters = [
      HTML::Pipeline::AddedMarkdownFilter,
      HTML::Pipeline::MarkdownFilter
    ]
    pipeline = HTML::Pipeline.new(filters)

    assert_equal pipeline.to_html(input), "<div class=\"alert tip\"><br>\n <strong>Tip</strong>: Wow! <br>\n </div>"
  end
end
