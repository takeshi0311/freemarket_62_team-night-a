class ItemsController < ApplicationController
  def index
  end

  def update
  end

  def edit
  end
  
  def buy
    @pay = Pay.where(user_id: current_user.id).first
    if @pay.blank?
      redirect_to action: "new"
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(@pay.customer_id)
      @default_card_information = customer.cards.retrieve(@pay.card_id)
    end
  end
end
