class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :follower]
  
  def index
    @users = User.paginate page: params[:page]
  end
  
  def new
    @user = User.new
  end

  def show
    @user = User.find params[:id]
  end  

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = 'Welcome to English World'
      redirect_to @user
    else
      render 'users/new'
    end  
  end
  
  def following
    @title = 'Following'
    @user = User.find params[:id]
    users = @user.following.paginate page: params[:page] 
    render 'show_follow'
  end

  def followers
    @title = 'Followers'
    @user  = User.find params[:id]
    @users = @user.followers.paginate page: params[:page]
    render 'show_follow'
  end

  private  
  def user_params
    params.require(:user).permit(:name, :email, :password, 
                                   :password_confirmation)
  end  
end