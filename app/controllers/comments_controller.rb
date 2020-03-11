class CommentsController < ApplicationController
  def create
    comment = Comment.create(text: comment_params[:text], item_id: comment_params[:item_id], user_id: current_user.id)
    redirect_to "item_path(comment.item.id)"   #コメントと結びつくアイテムの詳細画面に遷移す
    if comment.save
      flash[:notice] = "コメントしました"
    else
      flash[:notice] = "コメントできませんでした"
    end
  end

  private
  def comment_params
    params.permit(:text, :item_id)
  end

end

