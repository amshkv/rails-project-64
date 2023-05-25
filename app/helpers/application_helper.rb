# frozen_string_literal: true

module ApplicationHelper
  def render_nested_comments(comment)
    render 'posts/comment', comment: do
      comment.children.each do |c|
        render_nested_comments(c)
      end
    end
  end
end
