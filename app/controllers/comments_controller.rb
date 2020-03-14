class CommentsController < ApplicationController
  def create
    comment = current_user.comments.new(comment_params)
    if comment.save
      flash[:notice] = "コメントしました"
      redirect_to item_path(comment.item.id)   #コメントと結びつくアイテムの詳細画面に遷移
    else
      flash[:notice] = "コメントできませんでした"
      redirect_to item_path(comment.item.id)   #コメントと結びつくアイテムの詳細画面に遷移
    end
  end

  private
  def comment_params
    params.permit(:text, :item_id)
  end

end

