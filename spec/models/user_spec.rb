require 'rails_helper'

RSpec.describe User, type: :model do
  it 'email uniqueness' do
    User.create!(email: 'test@test', password: 'test')
    chelimsky = User.new(email: 'test@test.test', password: 'test')

    expect(chelimsky).to_not be_valid
  end
end
