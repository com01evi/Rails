class UsersController < ApplicationController
  def new
  end

  def show
      @user = User.find(params[:id])
      @articles = @user.articles.paginate(page: params[:page])
  end
end
