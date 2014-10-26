class ReviewsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @review = @user.references.new
  end

  def create
    @user = User.find(params[:user_id])
    @review = Review.new({
      work: review_params['work'], 
      comment: review_params['comment'], 
      reviewed: @user,
      reference: current_user
    })

    if @review.save
      redirect_to @review.reviewed, notice: "Thanks for giving a reference!"
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
