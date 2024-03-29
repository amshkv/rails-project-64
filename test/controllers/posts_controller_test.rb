# frozen_string_literal: true

require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:full)
    @post_another_author = posts(:with_another_author)
    user = users(:full)
    sign_in(user)

    @attrs = {
      title: Faker::Movie.title,
      body: [Faker::Movie.quote, Faker::Movie.quote].join(' '),
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

  test 'should create' do
    post posts_url, params: { post: @attrs }
    assert_response :redirect

    assert { Post.find_by(@attrs) }
  end

  test 'should get edit' do
    get edit_post_url(@post)

    assert_response :success
  end

  test 'should update' do
    patch post_url(@post), params: { post: @attrs }

    assert_response :redirect

    @post.reload

    assert { @post.title == @attrs[:title] }
    assert { @post.body == @attrs[:body] }
  end

  test 'should destroy' do
    delete post_url(@post)
    assert_response :redirect

    assert { !Post.find_by(id: @post.id) }
  end

  test 'should not get edit with another author' do
    get edit_post_url(@post_another_author)
    assert_response :redirect
  end

  test 'should not update with another author' do
    title = @post_another_author.title
    body = @post_another_author.body

    patch post_url(@post_another_author), params: { post: @attrs }

    assert_response :redirect

    @post_another_author.reload

    assert { @post_another_author.title == title }
    assert { @post_another_author.body == body }
  end

  test 'should not destroy with another author' do
    delete post_url(@post_another_author)
    assert_response :redirect

    assert { Post.find_by(id: @post_another_author.id) }
  end
end
