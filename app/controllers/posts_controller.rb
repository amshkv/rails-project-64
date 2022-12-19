# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :only_creator, only: %i[edit update destroy]

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

  def only_creator
    @post = Post.find(params[:id])

    redirect_to root_path, alert: I18n.t('posts.only_creator') unless @post.creator == current_user
  end
end
