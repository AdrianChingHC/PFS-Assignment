class SessionsController < ApplicationController
  
  before_filter :require_login, only: [:destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    
    if @user
      if @user.authenticate(params[:session][:password])
        session[:user_id] = @user.id
        redirect_to user_path(id: @user.id), notice: 'Welcome back!'
      else
        redirect_to sign_in_path, notice: 'Invalid Email or Password!'
      end
    else
      redirect_to sign_in_path, notice: 'Invalid Email or Password!'
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to sign_in_path, notice: 'Successfully Signed Out.'
  end
  
  

end
