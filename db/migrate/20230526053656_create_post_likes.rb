# frozen_string_literal: true

class CreatePostLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :post_likes do |t|
      t.references :post, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.index %i[post_id user_id], unique: true

      t.timestamps
    end
  end
end
