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
  end

  test 'should get destroy like' do
    post = posts(:harry)
    like = post_likes(:harry)

    delete post_like_url(post, like)
    assert_response :redirect

    # NOTE: можно так проверять, можно сяк, не знаю как правильнее и точнее
    assert_raises { PostLike.find(like.id) }
    assert { !PostLike.find_by(id: like.id) }
  end

  test 'should destroy by other user' do
    post = posts(:harry)
    like = post_likes(:hermione)

    delete post_like_url(post, like)
    assert_response :redirect

    assert { PostLike.find(like.id) }
  end
end
