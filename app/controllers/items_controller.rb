class ItemsController < ApplicationController
  def index
  end

  def update
  end

  def show
    gon.image = Image.find(1)
    @image = Image.find(1)
    @item = Item.find(1)
  end


  def edit
  end 

end



# def ensure_correct_user
#   @post = Post.find_by(id:params[:id])
#   if @user.user_id != @current_user.id
#     flash[:notice] = "権限がありません"
#     redirect_to("/items/edit")
# end