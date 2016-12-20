require 'rails_helper'

RSpec.describe User, type: :model do
  before { @user = create(:user) }

  it 'validates email uniqueness' do
    same_user = build(:user, username: 'different_user')
    expect(same_user).not_to be_valid
  end

  it 'validates username uniqueness' do
    same_user = build(:user, email: 'test1')
    expect(same_user).not_to be_valid
  end

  it 'respond to username, email, salaries' do
    expect(@user).to respond_to(:username, :email, :salaries)
  end
end
