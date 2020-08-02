module EmojiHelper
  def emoji(content, css_class: '', scale: nil)
    return '' if (emoji = Emoji.find_by_alias(content.to_s)).blank?

    content_tag(:span, emoji.raw, class: css_class.to_s, style: "transform: scale(#{scale})").html_safe
  end
end
