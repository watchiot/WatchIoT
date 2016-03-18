# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  username               :string(25)
#  first_name             :string(25)
#  last_name              :string(35)
#  address                :string
#  country_code           :string(3)
#  phone                  :string(15)
#  status                 :boolean          default(TRUE)
#  receive_notif_last_new :boolean          default(TRUE)
#  passwd                 :string
#  passwd_salt            :string
#  auth_token             :string
#  plan_id                :integer
#  api_key_id             :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  provider               :string
#  uid                    :string
#

##
# User controller
#
class UsersController < ApplicationController
  ##
  # GET /register
  #
  def register
    @user = User.new
    @email = Email.new
  end

  ##
  # POST /do_register
  #
  def do_register
    User.register(user_params, email_params[:email])

    render 'need_verify_notification'
  rescue => ex
    render 'register'
    flash[:error] = ex.message
  end

  ##
  # Get /login
  #
  def login
    @user = User.new
  end

  ##
  # POST /do_login
  #
  def do_login
    user = User.login(user_params[:username], user_params[:passwd])

    cookies[:auth_token] = user.auth_token unless user_params[:remember_me]
    cookies.permanent[:auth_token] = user.auth_token if user_params[:remember_me]

    redirect_to '/' + user.username
  rescue => ex
    render 'login'
    flash[:error] = ex.message
  end

  ##
  # Get /do_omniauth
  #
  def do_omniauth
    user = User.omniauth

    cookies[:auth_token] = user.auth_token

    redirect_to '/' + user.username
  rescue => ex
    flash[:error] = ex.message
  end

  ##
  # Get /logout
  #
  def logout
    cookies.clear

    redirect_to root_url
  end

  private

  ##
  # User params
  #
  def user_params
    params.require(:user).permit(:passwd, :passwd_confirmation, :username)
  end

  ##
  # Email params
  #
  def email_params
    params.require(:email).permit(:email)
  end
end
