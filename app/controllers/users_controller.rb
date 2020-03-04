class UsersController < ApplicationController
  def mypage
  end

  def logout
  end

  def address
    @address = Address.new
  end
  
  def register
    @address = Address.new(address_params)
    if @address.save
      redirect_to buy_items_path
    else
      render address_users_path
    end
  end

  def address_params
    params.require(:address).permit(:postal_code,:prefecture_id,:municipalitie,:street,:building).merge(user_id: current_user.id)
  end
end
