begin
  require 'nanoc3'
rescue LoadError
  require 'nanoc'
end
require 'html/pipeline'

module NanocHtmlPipeline
  class Filter < Nanoc::Filter

    def self.filter_key(s)
      s.to_s.downcase.to_sym
    end

    def self.is_filter(f)
      f < HTML::Pipeline::Filter
    rescue LoadError, ArgumentError
      false
    end

    # Runs the content through [HTML::Pipline](https://github.com/jch/html-pipeline).
    # Takes a `:pipeline` option as well as any additional context options.

    # @param [String] content The content to filter
    #
    # @return [String] The filtered content
    def run(content, params={})
      # Get options
      options = {:pipeline => []}.merge(params)

      filters = options.delete(:pipeline).map do |f|
        if self.class.is_filter(f)
          f
        else
          key = self.class.filter_key(f)
          filter = HTML::Pipeline.constants.find { |c| c.downcase == key }
          HTML::Pipeline.const_get(filter)
        end
      end

      HTML::Pipeline.new(filters, options).to_html(content)
    end
  end

end

Nanoc::Filter.register 'NanocHtmlPipeline::Filter', :html_pipeline
