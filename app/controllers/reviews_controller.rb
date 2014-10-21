class ReviewsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @review = @user.references.new
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to @user, notice: "Thanks for giving a reference!"
    else
      render :new
    end 
  end

  private

  def review_params
    params.require(:review).
    permit(:work, :comment)
  end

end
