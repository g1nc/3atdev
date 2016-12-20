require 'rails_helper'

RSpec.describe User, type: :model do
  it 'email uniqueness' do
    create(:user)
    same_email = build(:user)
    expect(same_email).not_to be_valid
  end
end
