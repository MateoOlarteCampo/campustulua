class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy, :activate_account]
  before_action :autenticathe_login!, except: [:create]
  before_action :autenticathe_admin!, only: [:active_account]
  before_action only: [:show, :update] do
    autenticathe_user!(@user)
  end

  def index
    respond_to do |format|
      format.json { @users = User.search(params[:search],params[:user]) }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        flash[:success] = "Cuenta creada exitosamente-Espere mientras su cuenta es activada."
        format.html { redirect_to welcome_path}
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render 'welcome/show' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params_update)
        format.html { redirect_to @user }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :show  }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
 
  def activate_account
    @user.update_attribute(:activated, true)
    respond_to do |format|
      format.json { render json: @user}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:identification, :name, :last_name, :email, :password, :password_confirmation, :profile_picture, :permission_level)
    end

    def user_params_update
      user_params = params.require(:user).permit(:name, :last_name, :email, :password, :password_confirmation, :profile_picture)
      user_params.delete(:password) unless user_params[:password].present?
      user_params.delete(:password_confirmation) unless user_params[:password_confirmation].present?
      user_params
    end

end
