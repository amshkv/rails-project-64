# frozen_string_literal: true

class CommentsController < ApplicationController
  def create # rubocop:disable Metrics/AbcSize
    @comment = current_user.comments.build(permitted_params)
    @comment.post = resource_post
    if @comment.save
      # TODO: разобраться как тут показывать ошибки у этой формы, если валидация не прошла или что-то пошло не так
      # кроме флешек?
      redirect_to resource_post, notice: I18n.t('comments.create.success')
    else
      @post = resource_post
      # TODO: иначе падает ошибка в кривом комменте, мб лучше `&` во вьюхе?, еще и рубокоп ругается на сложность
      @root_post_comments = @post.comments.roots
      flash[:alert] = I18n.t('comments.create.failure')
      redirect_to resource_post # TODO: если делать render, то падает что не может найти partial
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
