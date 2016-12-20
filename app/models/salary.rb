class Salary < ApplicationRecord
  before_save :set_dates

  belongs_to :user

  FIRST_DATE = 5
  SECOND_DATE = 20

  def set_dates
    if Salary.count.zero?
      if near_first_date?
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
      last_payment = Salary.order(:created_at).last
      self.starts_at = DateTime.new(last_payment.ends_at.year, last_payment.ends_at.month, last_payment.ends_at.day + 1)

      if last_payment.ends_at.day + 1 == FIRST_DATE
        ends_at = DateTime.new(self.starts_at.year, self.starts_at.month, SECOND_DATE - 1)
      else
        ends_at = DateTime.new(self.starts_at.year, self.starts_at.month, FIRST_DATE - 1)
        ends_at += 1.month
      end
      self.ends_at = ends_at
    end
  end

  def near_first_date?
    DateTime.now.day - FIRST_DATE < DateTime.now.day - SECOND_DATE
  end

  def delete_payment(user)
    delete if self.user == user
  end
end
