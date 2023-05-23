# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(permitted_params)
    @comment.post = resource_post
    if @comment.save
      # а как тут показывать ошибки у этой формы, если валидация не прошла или что-то пошло не так
      # кроме флешек?
      redirect_to resource_post, notice: I18n.t('comments.create.success')
    else
      @post = resource_post
      flash[:alert] = I18n.t('comments.create.failure')
      render 'posts/show'
    end
  end

  private

  def permitted_params
    params.require(:post_comment).permit(:content)
  end

  def resource_post
    Post.find(params[:post_id])
  end
end
