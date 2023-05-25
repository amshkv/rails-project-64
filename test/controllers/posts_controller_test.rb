# frozen_string_literal: true

require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
    @user = users(:harry)
    sign_in(@user)

    @attrs = {
      title: Faker::Movies::HarryPotter.book,
      body: [Faker::Movies::HarryPotter.quote, Faker::Movies::HarryPotter.quote].join(' '),
      category_id: categories(:spells).id
    }
  end

  test 'should get index / root' do
    get root_url # older posts_url
    assert_response :success
  end

  test 'should get show' do
    get post_url(@post)
    assert_response :success
  end

  test 'should get new' do
    get new_post_url
    assert_response :success
  end

  test 'should get create' do
    post posts_url, params: { post: @attrs }
    assert_response :redirect

    post = Post.find_by(title: @attrs[:title])
    assert { post }
  end

  test 'should get edit' do
    get edit_post_url(@post)

    assert_response :success
  end

  test 'should get update' do
    patch post_url(@post), params: { post: @attrs }

    assert_response :redirect

    @post.reload

    assert { @post.title == @attrs[:title] }
    assert { @post.body == @attrs[:body] }
  end

  test 'should get destroy' do
    delete post_url(@post)
    assert_response :redirect

    assert { !Post.find_by(id: @post.id) }
  end
end
