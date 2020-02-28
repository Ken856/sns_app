class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def show
    @user = User.find(params[:id])
    @room = current_user.personal_chat_room(@user)
    #@new_room = Room.find_or_initialize_by(id: @chat_room)
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      log_in user
      flash[:notice] = "登録が完了しました。"
      redirect_to user
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user.update_attributes(user_params)
      flash[:notice] = "保存しました"
      redirect_to user
    else
      render 'edit'
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    flash[:success] = "退会しました"
    redirect_to users_url
  end

  def top
    @user = User.find(params[:id])
    @groups = current_user.groups.all
    @users = @user.following.all
    # if params[:search]
    #   @searches = User.where('name LIKE (?)', "%#{params[:search]}%")
    # else
    #   @searches = User.none
    # end
    @searches = User.search(params[:search], "name")
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
    end

    def correct_user
      @user = User.find(params[:id])
      unless current_user?(@user)
        redirect_to root_url
      end
    end
end
