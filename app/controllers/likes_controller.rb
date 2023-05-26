# frozen_string_literal: true

class LikesController < ApplicationController
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

  def resource_post
    Post.find(params[:post_id])
  end
end
