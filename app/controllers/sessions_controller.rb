class SessionsController < ApplicationController
  

 def create
    user = User.find_by(identification: params[:session][:identification])
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        sign_in user
        redirect_back_or root_path
      else
        @user = User.new
        flash.now[:warning] = "Espere mientras su cuenta es activada por nuestro personal"
        render 'welcome/show'
      end
    else
      @user = User.new
      flash.now[:danger] = 'Usuario o contaseña incorrecta'
      render 'welcome/show'
    end
  end

 def destroy
    sign_out
    redirect_to welcome_path
  end

end
