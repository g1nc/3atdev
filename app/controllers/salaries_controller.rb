class SalariesController < ApplicationController
  before_action :authenticate_user!

  def index
    @salaries = Salary.all
  end
end
