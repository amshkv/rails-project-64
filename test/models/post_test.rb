# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id          :integer          not null, primary key
#  body        :text
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer          not null
#  creator_id  :integer          not null
#
# Indexes
#
#  index_posts_on_category_id  (category_id)
#  index_posts_on_creator_id   (creator_id)
#
# Foreign Keys
#
#  category_id  (category_id => categories.id)
#  creator_id   (creator_id => users.id)
#
require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
