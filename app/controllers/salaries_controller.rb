class SalariesController < ApplicationController
  before_action :authenticate_user!

  def index
    @salaries = Salary.order(ends_at: :asc).page params[:page]
  end

  def new
    current_user.salaries.build.save
    redirect_back(fallback_location: root_path, notice: 'Payment successfully created')
  end

  def destroy
    salary = Salary.find(params[:id])
    salary.destroy if current_user == salary.user
    redirect_to root_path
  end
end
