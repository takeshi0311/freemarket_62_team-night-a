class PaysController < ApplicationController
  before_action :authenticate_user!
  require "payjp"

  def new
    pay = Pay.where(user_id: current_user.id)
    redirect_to pay_path(current_user) if pay.exists?
  end

  def register
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
      description: '登録テスト',
      email: current_user.email,
      card: params['payjp-token'],
      metadata: {user_id: current_user.id}
      )
      @pay = Pay.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @pay.save
        redirect_to root_path, notice:"登録しました"
      else
        redirect_to action:"new"
      end
    end
  end

  def destroy
    pay = Pay.where(user_id: current_user.id).first
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    customer = Payjp::Customer.retrieve(pay.customer_id)
    pay.delete
    if pay.destroy
      redirect_to action: "new", notice: "削除しました"
    else
      redirect_to action: "new", alert:  "削除できません"
    end
  end

  def show
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
