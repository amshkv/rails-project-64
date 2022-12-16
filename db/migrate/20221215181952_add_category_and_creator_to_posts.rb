# frozen_string_literal: true

class AddCategoryAndCreatorToPosts < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :category, null: false, foreign_key: true # rubocop:disable Rails/NotNullColumn
    add_reference :posts, :creator, null: false, foreign_key: false # rubocop:disable Rails/NotNullColumn
    add_foreign_key :posts, :users, column: :creator_id
  end
end
