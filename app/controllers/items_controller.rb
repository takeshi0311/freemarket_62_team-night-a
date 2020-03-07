class ItemsController < ApplicationController
  def index
  end

  def update
  end
  
  def buy
    @address = Address.where(user_id: current_user.id).first
    @pay = Pay.where(user_id: current_user.id).first
    if @pay.blank?
      redirect_to action: "new"
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(@pay.customer_id)
      @default_card_information = customer.cards.retrieve(@pay.card_id)
    end
  end

  def show
  end


  def edit
    gon.image = Image.find(1)
    @image = Image.find(1)
    @item = Item.find(1)
  end 
end
