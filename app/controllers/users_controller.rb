class UsersController < ApplicationController
  def mypage
  end

  def logout
  end

  def index
  end

  def show
    user = User.find(params[:id])
    @nickname = user.nickname
    @item = user.item.page(params[:page]).per(5).order("created_at DESC")
  end
  
end
