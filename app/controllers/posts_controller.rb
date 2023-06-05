# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy edit new update]

  def index
    @posts = Post.all.includes([:creator]).order(id: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes([:user]).arrange
    @new_comment = @post.comments.build
    @like_of_current_user = @post.likes.find_by(user: current_user)
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])

    redirect_to(@post, alert: I18n.t('posts.only_author')) and return unless author?(@post)
  end

  def create
    @post = current_user.posts.build(permitted_params)

    if @post.save
      redirect_to @post, notice: I18n.t('posts.create.success')
    else
      render :new, status: :unprocessable_entity, alert: I18n.t('posts.create.failure')
    end
  end

  def update
    @post = Post.find(params[:id])

    redirect_to(@post, alert: I18n.t('posts.only_author')) and return unless author?(@post)

    if @post.update(permitted_params)
      redirect_to @post, notice: I18n.t('posts.update.success')
    else
      render :edit, status: :unprocessable_entity, alert: I18n.t('posts.update.failure')
    end
  end

  def destroy
    @post = Post.find(params[:id])

    redirect_to(@post, alert: I18n.t('posts.only_author')) and return unless author?(@post)

    @post.destroy

    redirect_to root_path, notice: I18n.t('posts.destroy.success')
  end

  private

  def permitted_params
    params.require(:post).permit(:title, :body, :category_id)
  end

  def author?(post)
    post.creator == current_user
  end
end
