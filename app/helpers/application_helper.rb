# frozen_string_literal: true

module ApplicationHelper
  def render_nested_comments(comment)
    render 'posts/comment', comment: do
      comment.children.map do |c|
        render_nested_comments(c)
      end.join.html_safe # rubocop:disable Rails/OutputSafety
    end
  end
end
