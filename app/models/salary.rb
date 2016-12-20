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

  def last_payment
    Salary.order(:created_at).last
  end

  def set_dates
    self.starts_at = get_starts_at
    self.ends_at = get_ends_at(self.starts_at)
  end

  def get_starts_at
    last = last_payment
    return last.ends_at.tomorrow if last

    get_nearest_date(Date.today)
  end

  def get_ends_at(date)
    get_nearest_date(date.tomorrow).yesterday
  end

  def get_nearest_date(date_from)
    [date_from, date_from.at_beginning_of_month.next_month].each do |date|
      result = PAYMENT_DAYS.map { |d| date.change(day: d) }.detect { |d| date <= d }
      return result unless result.blank?
    end
  end
end
