# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :only_creator, only: %i[destroy]

  def create
    like = current_user.likes.build
    like.post = resource_post

    if like.save
      redirect_to resource_post
    else
      alert = like.errors.full_messages.join(', ')
      redirect_to resource_post, status: :unprocessable_entity, alert:
    end
  end

  def destroy
    like = PostLike.find(params[:id])

    like.destroy

    redirect_to resource_post
  end

  private

  def resource_post
    @resource_post ||= Post.find(params[:post_id])
  end

  def only_creator
    like = PostLike.find(params[:id])
    redirect_to resource_post, alert: I18n.t('likes.destroy.failure') unless like.user == current_user
  end
end
