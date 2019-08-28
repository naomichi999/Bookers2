class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
  	@book = Book.new
  	@users = User.all

  end

  def show
  	@book = Book.new
  	@books = Book.all
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to user_path(current_user)
    else
      render :edit
    end
    # ↑他のユーザの編集画面に飛ぼうとするとカレントユーザのshowページに飛ぶ
    # renderは直接editページに飛ぶ(redirect_toはroutingからcontrollerでactionを呼び出してからそのページに飛ぶ)
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    redirect_to user_path(current_user)
    flash[:notice] = "You have updated user successfully."
    else
      render :edit
    end

  end

  protected
  def user_params
      params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
