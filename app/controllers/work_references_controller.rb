class WorkReferencesController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @work_reference = @user.work_references_written.new
  end

  def create
    @user = User.find(params[:user_id])
    @work_reference = WorkReference.new({
      work: work_reference_params['work'],
      comment: work_reference_params['comment'],
      worker_user: @user,
      employer_user: current_user
    })
    if @work_reference.save
      redirect_to @work_reference.worker_user, notice: "Thanks for giving a reference!"
    else
      render :new
    end
  end

  private

  def work_reference_params
    params.require(:work_reference).
    permit(:work, :comment)
  end
end
