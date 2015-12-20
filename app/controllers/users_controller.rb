class UsersController < ApplicationController
  def new
      @user = User.new
  end

  def create 
      @user = User.new(user_params)
      if @user.save
          flash[:success] = "Welcome to the Sample App!"
          redirect_to @user

      else
          render 'new'

      end
  end

  def show
      @user = User.find(params[:id])
      @articles = @user.articles.paginate(page: params[:page])
  end

  def edit
      @user
  end

  private

  def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end

