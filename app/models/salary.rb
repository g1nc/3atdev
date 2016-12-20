class Salary < ApplicationRecord
  PAYMENT_DAYS = [5, 15, 20]

  belongs_to :user
  validates :user_id, presence: true
  before_save :set_dates

  def self.min_start_date
    Salary.order(starts_at: :asc).first.starts_at
  end

  def self.max_end_date
    Salary.order(ends_at: :asc).last.ends_at
  end

  private

  def set_dates
    last = last_payment
    if last.nil?
      self.starts_at = get_starts_at
      self.ends_at = get_ends_at(self.starts_at)
    else
      self.starts_at = last.ends_at + 1.day
      self.ends_at = get_ends_at(self.starts_at)
    end
  end

  def last_payment
    Salary.order(:created_at).last
  end

  def get_starts_at
    diff = {}
    PAYMENT_DAYS.each_with_index do |val, index|
      diff[index] = Date.today.day - val
    end
    nearest = diff.sort_by { |index, val| val }[0][0]
    Date.new(Date.today.year, Date.today.month, PAYMENT_DAYS[nearest])
  end

  def get_ends_at (date)
    current_day_index = PAYMENT_DAYS.index(date.day)
    if current_day_index == PAYMENT_DAYS.count - 1
      end_date = Date.new(date.year, date.month, PAYMENT_DAYS[0] - 1)
      end_date += 1.month
    else
      end_date = Date.new(date.year, date.month, PAYMENT_DAYS[current_day_index + 1] - 1)
    end
    end_date
  end
end
