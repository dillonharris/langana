class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
#    @reviews_given = @user.reviews_given
#    @favorite_movies = @user.favorite_movies
  end
end
