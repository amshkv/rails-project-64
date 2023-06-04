# frozen_string_literal: true

require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:full)
    sign_in(@user)
  end

  test 'should add like' do
    post = posts(:without_likes)

    post post_likes_url(post)
    assert_response :redirect

    assert { post.likes.find_by(user: @user) }
  end

  test 'should destroy like' do
    post = posts(:full)
    like = post_likes(:full)

    delete post_like_url(post, like)
    assert_response :redirect

    assert { !PostLike.find_by(id: like.id) }
  end

  test 'should not destroy by other user' do
    post = posts(:full)
    like = post_likes(:another)

    delete post_like_url(post, like)
    assert_response :redirect

    assert { PostLike.find(like.id) }
  end
end
