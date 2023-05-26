# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    comment = current_user.comments.build(permitted_params)
    comment.post = resource_post
    if comment.save
      redirect_to resource_post, notice: I18n.t('comments.create.success')
    else
      alert = comment.errors.full_messages.join(', ')
      redirect_to resource_post, status: :unprocessable_entity, alert:
    end
  end

  private

  def permitted_params
    params.require(:post_comment).permit(:content, :parent_id)
  end

  def resource_post
    Post.find(params[:post_id])
  end
end
