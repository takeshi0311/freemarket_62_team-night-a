class UsersController < ApplicationController
  before_action :set_current_user, only: :register

  def mypage
  end

  def logout
  end


  def address
    @user = User.new
    @address = @user.build_address
    address= Address.where(user_id: current_user.id)
    redirect_to buy_items_path if address.exists?
  end
  
  def index

  end

  def show
    user = User.find(params[:id])
    @nickname = user.nickname
    @item = user.item.page(params[:page]).per(5).order("created_at DESC")
  end
  
  def register
    @user = User.new(id:current_user.id)
    @address = @user.build_address(user_params[:address_attributes])
    if @address.save
      redirect_to buy_items_path
    else
      render address_users_path
    end
  end

  private
  def user_params
    params.require(:user).permit(
      :id,
      :family_name,
      :last_name,
      :frigana_family_name,
      :frigana_last_name,
      address_attributes: [
        :id,
        :postal_code,
        :prefecture_id,
        :municipalitie,
        :street,
        :building,
      ]
  )
  end

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  def address_params
    params.require(:address).permit(:postal_code,:prefecture_id,:municipalitie,:street,:building).merge(user_id: current_user.id)
  end
end
