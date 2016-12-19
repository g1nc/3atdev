class Salary < ApplicationRecord
  before_save :set_dates
  belongs_to :user

  FIRST_DATE = 5
  SECOND_DATE = 20

  def set_dates
    if Salary.count.zero?
      if DateTime.now.day - FIRST_DATE < DateTime.now.day - SECOND_DATE
        starts_at = DateTime.new(DateTime.now.year, DateTime.now.month, FIRST_DATE)
        ends_at = DateTime.new(DateTime.now.year, DateTime.now.month, SECOND_DATE - 1)
      else
        starts_at = DateTime.new(DateTime.now.year, DateTime.now.month, SECOND_DATE)
        ends_at = DateTime.new(DateTime.now.year, DateTime.now.month, FIRST_DATE - 1)
      end
      ends_at += 1.month

      self.starts_at = starts_at
      self.ends_at = ends_at
    else
      last_payment = Salary.order(ends_at: :desc).first

      self.starts_at = DateTime.new(last_payment.ends_at.year, last_payment.ends_at.month, last_payment.ends_at.day + 1)
      ends_at = DateTime.new(self.starts_at.year, self.starts_at.month, last_payment.starts_at.day - 1)
      ends_at += 1.month
      self.ends_at = ends_at
    end
  end
end
