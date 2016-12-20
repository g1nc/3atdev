module SalariesHelper
  def format_starts(salary)
    salary.starts_at.strftime("%b %d, %Y")
  end

  def format_ends(salary)
    salary.ends_at.strftime("%b %d, %Y")
  end
end