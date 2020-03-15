class PurchaseController < ApplicationController
  require 'payjp'

  def index
    @item = Item.find(params[:id])
    pay = Pay.where(user_id: current_user.id).first
    if pay.blank?
      redirect_to controller: "pays", action: "new"
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(pay.customer_id)
      @default_card_information = customer.cards.retrieve(pay.card_id)
      redirect_to action: "pay"
    end
  end

  def pay
    @item = Item.find(params[:id])
    pay = Pay.where(user_id: current_user.id).first
    if pay.blank?
      redirect_to controller: "pays", action: "new"
    else
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    Payjp::Charge.create(
      :amount => @item.price,
      :customer => pay.customer_id,
      :currency => 'jpy'
    )
    redirect_to root_path, notice: '商品の購入が完了しました'
    end
  end
end
