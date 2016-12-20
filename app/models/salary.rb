class Salary < ApplicationRecord
  validates :user_id, presence: true
  before_save :set_dates

  belongs_to :user

  FIRST_DATE = 5
  SECOND_DATE = 20

  protected

  def set_dates
    if Salary.count.zero?
      if near_first_date?
        starts_at = Date.new(Date.today.year, Date.today.month, FIRST_DATE)
        ends_at = Date.new(Date.today.year, Date.today.month, SECOND_DATE - 1)
      else
        starts_at = Date.new(Date.today.year, Date.today.month, SECOND_DATE)
        ends_at = Date.new(Date.today.year, Date.today.month, FIRST_DATE - 1)
      end
      ends_at += 1.month

      self.starts_at = starts_at
      self.ends_at = ends_at
    else
      last_payment = Salary.order(:created_at).last
      self.starts_at = Date.new(last_payment.ends_at.year, last_payment.ends_at.month, last_payment.ends_at.day + 1)

      if last_payment.ends_at.day + 1 == FIRST_DATE
        ends_at = Date.new(self.starts_at.year, self.starts_at.month, SECOND_DATE - 1)
      else
        ends_at = Date.new(self.starts_at.year, self.starts_at.month, FIRST_DATE - 1)
        ends_at += 1.month
      end
      self.ends_at = ends_at
    end

    def near_first_date?
      Date.today.day - FIRST_DATE < Date.today.day - SECOND_DATE
    end

    def delete_payment(user)
      delete if self.user == user
    end
  end
end
