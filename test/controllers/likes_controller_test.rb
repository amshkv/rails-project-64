# frozen_string_literal: true

require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:harry)
    sign_in(@user)
  end

  test 'should get add like' do
    post = posts(:hermione)

    post post_likes_url(post)
    assert_response :redirect

    assert { post.likes.find_by(user: @user) }

    post post_likes_url(post)
    assert_response 422

    assert { post.likes.where(user: @user).one? }
  end

  test 'should get destroy like' do
    post = posts(:harry)
    like = post_likes(:harry)

    delete post_like_url(post, like)
    assert_response :redirect

    assert { !post.likes.find_by(user: @user) }
  end

  test 'should destroy by other user' do
    post = posts(:harry)
    like = post_likes(:hermione)

    delete post_like_url(post, like)
    assert_response :redirect

    assert { post.likes.find(like.id) }
  end
end
