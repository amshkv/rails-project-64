# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(permitted_params)
    @comment.post = resource_post
    if @comment.save
      redirect_to resource_post, notice: I18n.t('comments.create.success')
    else
      redirect_to resource_post, status: :unprocessable_entity, alert: I18n.t('comments.create.failure')
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
