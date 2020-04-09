class ApplicationController < ActionController::Base
  before_action :set_parents
  before_action :basic_auth, if: :production?
  before_action :set_search
  protect_from_forgery with: :exception
  private
  def production?
    Rails.env.production?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

  def set_search
    
    @q = Item.ransack(params[:q]) #ransackメソッド推奨
  end

  def set_parents
    @parents = Category.where(ancestry: nil)
  end
end