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
    @address.save
    redirect_to buy_items_path
  end

  def address_params
    params.require(:address).permit(:postal_code,:prefecture,:municipalitie,:street,:building).merge(user_id: current_user.id)
  end
end
