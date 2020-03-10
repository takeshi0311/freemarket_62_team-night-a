class ItemsController < ApplicationController

  before_action :ensure_correct_user,{only: [:edit,:buy,]} 

  def index
    @image = Image.all
    @item = Item.all
  end

  def update
  end

  def show
    gon.image = Image.find(1)
    @image = Image.find(1)
    @item = Item.find(1)
    @user = User.find(1)
  end

  # 出品者以外がURLから直接的に編集、購入画面に進めないようにするため
  def ensure_correct_user
      @item = Item.find(1)
    if @item.user_id != current_user.id
      flash[:notice] = "権限がありません"
      redirect_to(item_path(@item))
    end
  end
  
  def destroy
    @item = Item.find(params[:id])
    if @item.user_id == current_user.id && @item.destroy
      flash[:notice] = "削除しました"
    else
      flash[:notice] = "削除できませんでした"
      redirect_to(item_path(@item))
    end
  end

  def edit
  end 

end
