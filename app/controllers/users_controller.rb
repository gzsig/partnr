class UsersController < ApplicationController
  before_action :set_user, except: %i[new create]

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.user = current_user
    if @user.save
      redirect_to @user
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    # sign_out @user
    @user.user.destroy

    redirect_to :root
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :bio, :phone_number, :CPF, :occupation, :address)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
