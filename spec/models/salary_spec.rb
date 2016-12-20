require 'rails_helper'

RSpec.describe Salary, type: :model do
  before { @salary = create(:salary) }

  it 'respond to starts_at, ends_at, user_id' do
    expect(@salary).to respond_to(:starts_at, :ends_at, :user_id)
  end

  it 'have starts_at' do
    expect(@salary.starts_at).to be_instance_of Date
  end

  it 'have ends_at' do
    expect(@salary.ends_at).to be_instance_of Date
  end

  it 'belongs to user' do
    expect(@salary.user).to be_instance_of User
  end

  it 'invalid if have not user' do
    salary = Salary.new
    expect(salary).not_to be_valid
  end

  it 'have starts_at today if not other salary presented' do
    expect(@salary.starts_at).to eq(Date.today)
  end

  it 'have start_at next day from previous salary ends_at' do
    salary = create(:salary, user: create(:user, email: 'test2@test.test'))
    expect(salary.starts_at).to eq(Date.new(@salary.ends_at.year, @salary.ends_at.month, @salary.ends_at.day + 1))
  end
end
