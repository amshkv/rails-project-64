# frozen_string_literal: true

class AddAncestryToPostComment < ActiveRecord::Migration[7.0]
  def change
    add_column :post_comments, :ancestry, :string
    add_index :post_comments, :ancestry
  end
end
