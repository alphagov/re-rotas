require 'test_helper'

def assert_same_no_ws(a, b)
  assert_equal a.lines.map(&:strip).join(''),
               b.lines.map(&:strip).join('')
end

class WhoIsOnCallMarkdownRendererTest < ActiveSupport::TestCase
  test 'ul' do
    markdown = <<~MD
      - item
      - item
      - item
    MD
    html = WhoIsOnCall::MarkdownRenderer.render(markdown)
    expected_html = <<~HTML
      <ul class="govuk-list govuk-list--bullet">
        <li>item</li>
        <li>item</li>
        <li>item</li>
      </ul>
    HTML

    assert_same_no_ws(html, expected_html)
  end

  test 'ol' do
    markdown = <<~MD
      1. item
      1. item
      1. item
    MD
    html = WhoIsOnCall::MarkdownRenderer.render(markdown)
    expected_html = <<~HTML
      <ol class="govuk-list govuk-list--number">
        <li>item</li>
        <li>item</li>
        <li>item</li>
      </ol>
    HTML

    assert_same_no_ws(html, expected_html)
  end

  test 'link' do
    markdown = <<~MD
      [link](https://href)
    MD
    expected_html = <<~HTML
      <p class="govuk-body">
        <a href="https://href" title="" class="govuk-link">link</a>
      </p>
    HTML
    html = WhoIsOnCall::MarkdownRenderer.render(markdown)

    assert_same_no_ws(html, expected_html)
  end

  test 'script safe' do
    markdown = <<~MD
      <script>alert(1);</script>
    MD
    html = WhoIsOnCall::MarkdownRenderer.render(markdown)
    assert_equal '', html
  end
end
