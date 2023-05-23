# frozen_string_literal: true

require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  test 'should create comment' do
    post = posts(:one)
    user = users(:harry)
    sign_in(user)

    attrs = {
      content: Faker::Movies::HarryPotter.quote
    }

    old_post_comments_count = post.comments.count

    post post_comments_path(post), params: { post_comment: attrs }
    assert_response :redirect

    post.reload

    # NOTE: что-то хз как правильно проверить что коммент создался у поста (проверка на +1 может и лишняя)
    assert { post.comments.count == old_post_comments_count + 1 }
    assert { post.comments.last.content == attrs[:content] }
  end
end
