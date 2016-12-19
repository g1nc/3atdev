class SalariesController < ApplicationController
  before_action :authenticate_user!

  def index
    @salaries = Salary.order(ends_at: :asc).page params[:page]
  end

  def new
    current_user.salaries.build.save
    redirect_to :back, notice: 'Payment successfully created'
  end

  def destroy
    Salary.find(params[:id]).delete
    redirect_to :back
  end
end
