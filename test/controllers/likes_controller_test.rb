# frozen_string_literal: true

require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:harry)
    sign_in(@user)
  end

  test 'should get add like' do
    post = posts(:two)

    user_like_old_count = post.likes.where(user: @user).count

    post post_likes_url(post)
    assert_response :redirect

    user_like_new_count = post.likes.where(user: @user).count

    assert { user_like_old_count + 1 == user_like_new_count }
    assert { post.likes.find_by(user: @user) }

    post post_likes_url(post)
    assert_response 422

    double_user_like_count = post.likes.where(user: @user).count

    assert { user_like_new_count == double_user_like_count }
  end

  test 'should get destroy like' do
    post = posts(:one)
    like = post_likes(:one)

    user_like_old_count = post.likes.where(user: @user).count

    delete post_like_url(post, like)
    assert_response :redirect

    user_like_new_count = post.likes.where(user: @user).count

    assert { user_like_old_count - 1 == user_like_new_count }
    assert { !post.likes.find_by(user: @user) }
  end
end
