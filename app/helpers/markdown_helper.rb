module MarkdownHelper
  def markdown(text)
    pipeline = HTML::Pipeline.new [
      HTML::Pipeline::MarkdownFilter,
      HTML::Pipeline::SyntaxHighlightFilter
    ]
    result = pipeline.call(text)
    result[:output].to_s.html_safe
  end
end
