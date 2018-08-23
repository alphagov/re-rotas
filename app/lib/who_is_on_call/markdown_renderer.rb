module WhoIsOnCall
  class MarkdownRenderer < ::Redcarpet::Render::Safe
    def block_html(raw_html)
      # No user input HTML please
    end

    def raw_html(raw_html)
      # No user input HTML please
    end

    def list(content, list_type)
      case list_type
      when :ordered
        <<~HTML
          <ol class="govuk-list govuk-list--number">
            #{content}
          </ol>
        HTML
      when :unordered
        <<~HTML
          <ul class="govuk-list govuk-list--bullet">
            #{content}
          </ul>
        HTML
      end
    end

    def link(link, title, content)
      <<~HTML
        <a href="#{link}" title="#{title}" class="govuk-link">
          #{content}
        </a>
      HTML
    end

    def paragraph(text)
      %(<p class="govuk-body">#{text}</p>)
    end

    def header(text, heading_level)
      tag  = "h#{heading_level}"
      size = case heading_level
             when 1
               'xl'
             when 2
               'l'
             when 3
               'm'
             else
               's'
             end

      <<~HTML
        <#{tag} class="govuk-heading-#{size}">
          #{text}
        </#{tag}>
      HTML
    end

    def self.render(content)
      Redcarpet::Markdown.new(self).render(content)
    end
  end
end
