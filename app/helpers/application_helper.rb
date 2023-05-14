# frozen_string_literal: true

module ApplicationHelper
  def format_date(date)
    date.strftime('%Y年%m月%d日')
  end

  def truncate_text(text, limit)
    if text.length > limit
      truncated_text = text[0...limit]
      truncated_text += '...'
      truncated_text
    else
      text
    end
  end
end
