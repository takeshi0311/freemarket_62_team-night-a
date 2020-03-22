class SignupController < ApplicationController
  before_action :validates_member, only: [:done]
  before_action :validates_sms, only: [:done]
  def index
  end

  def member
    
    @user = User.new
  end

  def sms
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:password_confirmation] = user_params[:password_confirmation]
    session[:family_name] = user_params[:family_name]
    session[:last_name] = user_params[:last_name]
    session[:frigana_family_name] = user_params[:frigana_family_name]
    session[:frigana_last_name] = user_params[:frigana_last_name]
    session[:birthday_year] = user_params[:birthday_year]
    session[:birthday_month] = user_params[:birthday_month]
    session[:birthday_day] = user_params[:birthday_day]
  if params[:sns_auth] == 'true' #viweから= hidden_field_tagより :sns_auth, trueが送られてきたら実行
      pass = Devise.friendly_token #params[:sns_auth]が送られて来た時だけDevise.friendly_tokenを使ってパスワードを自動生成し、パスワードを不要に。
      session[:password] = pass
      session[:password_confirmation] = pass
    end
    @user = User.new
  end

  def done
  end

  def create
    session[:phone_number] = user_params[:phone_number]
    @user = User.new(
      nickname: session[:nickname], 
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      reset_password_token: session[:reset_password_token],
      reset_password_sent_at: session[:reset_password_sent_at],
      family_name: session[:family_name],
      last_name: session[:last_name],
      frigana_family_name: session[:frigana_family_name],
      frigana_last_name: session[:frigana_last_name],
      phone_number: session[:phone_number],
      birthday_year: session[:birthday_year],
      birthday_month: session[:birthday_month],
      birthday_day: session[:birthday_day]
    )

    if @user.save
      session[:id] = @user.id
      sign_in User.find(session[:id]) unless user_signed_in?
      render '/signup/done'
    else
      render '/signup/index'
    end
    
  end



  private
  def user_params
    params.require(:user).permit(
      :nickname,
      :email,
      :password,
      :password_confirmation,
      :family_name,
      :last_name,
      :frigana_family_name,
      :frigana_last_name,
      :birthday_year,
      :birthday_month, 
      :birthday_day,
      :phone_number,
  )
  end

  def validates_member
    # step1で入力された値をsessionに保存
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:password_confirmation] = user_params[:password_confirmation]
    session[:family_name] = user_params[:family_name]
    session[:last_name] = user_params[:last_name]
    session[:frigana_family_name] = user_params[:frigana_family_name]
    session[:frigana_last_name] = user_params[:frigana_last_name]
    session[:birthday_year] = user_params[:birthday_year]
    session[:birthday_month] = user_params[:birthday_month]
    session[:birthday_day] = user_params[:birthday_day]
    # バリデーション用に、仮でインスタンスを作成する
    @user = User.new(
      nickname: session[:nickname], # sessionに保存された値をインスタンスに渡す
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      family_name: session[:family_name],
      last_name: session[:last_name],
      frigana_family_name: session[:frigana_family_name],
      frigana_last_name: session[:frigana_last_name],
      birthday_year: session[:birthday_year],
      birthday_month: session[:birthday_month],
      birthday_day: session[:birthday_day],
      phone_number: "09012345678" #次のページのバリデーションをパスするために仮置き
    )
    # 

    render '/signup/member' unless @user.valid?
  end

  def validates_sms
    # smsで入力された値をsessionに保存
    session[:phone_number] = user_params[:phone_number]
    # バリデーション用に、仮でインスタンスを作成する
    @user = User.new(
      nickname: session[:nickname], # sessionに保存された値をインスタンスに渡す
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      family_name: session[:family_name],
      last_name: session[:last_name],
      frigana_family_name: session[:frigana_family_name],
      frigana_last_name: session[:frigana_last_name],
      birthday_year: session[:birthday_year],
      birthday_month: session[:birthday_month],
      birthday_day: session[:birthday_day],
      phone_number: session[:phone_number],
    )
    # 仮で作成したインスタンスのバリデーションチェックを行う
    render '/signup/sms' unless @user.valid?
  end 
end
