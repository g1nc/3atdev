class SalariesController < ApplicationController
  before_action :authenticate_user!

  def index
    @salaries = Salary.all
  end

  def new
    current_user.salaries.build.save
    redirect_to :back, notice: 'Payment successfully created'
  end

  def destroy
    Salary.find(params[:id]).delete
    redirect_to salaries_path
  end
end
