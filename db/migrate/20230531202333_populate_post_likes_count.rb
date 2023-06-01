# frozen_string_literal: true

class PopulatePostLikesCount < ActiveRecord::Migration[7.0]
  def up
    Post.find_each do |post|
      Post.reset_counters(post.id, :likes)
    end
  end
end
