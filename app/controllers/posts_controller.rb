# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    params = { creator: current_user }.merge(permitted_params)
    @post = Post.new(params)

    if @post.save
      redirect_to @post, notice: I18n.t('posts.create.success')
    else
      render :new, status: :unprocessable_entity, alert: I18n.t('posts.create.failure')
    end
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(permitted_params)
      redirect_to @post, notice: I18n.t('posts.update.success')
    else
      render :edit, status: :unprocessable_entity, alert: I18n.t('posts.update.failure')
    end
  end

  def destroy
    @post = Post.find(params[:id])

    @post.destroy

    redirect_to root_path, notice: I18n.t('posts.destroy.success')
  end

  private

  def permitted_params
    params.require(:post).permit(:title, :body, :category_id)
  end
end
