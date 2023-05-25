# frozen_string_literal: true

require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
    user = users(:harry)
    sign_in(user)
  end

  test 'should create comment with parent_id' do
    parent = @post.comments.first

    attrs = {
      content: Faker::Movies::HarryPotter.quote,
      parent_id: parent.id
    }

    post post_comments_path(@post), params: { post_comment: attrs }
    assert_response :redirect

    @post.reload

    comment = @post.comments.find_by(content: attrs[:content])
    assert { comment }
    assert { comment.parent = parent }
  end

  test 'should create comment without parent_id' do
    attrs = {
      content: Faker::Movies::HarryPotter.quote,
      parent_id: nil
    }

    post post_comments_path(@post), params: { post_comment: attrs }
    assert_response :redirect

    @post.reload

    comment = @post.comments.find_by(content: attrs[:content])
    assert { comment }
  end
end
