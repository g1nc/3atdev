require 'rails_helper'

RSpec.describe SalariesController, type: :controller do
  describe 'GET #index' do
    it 'moved if not authenticated' do
      get :index
      expect(response).to have_http_status(302)
    end

    it 'success if authenticated' do
      sign_in create(:user)
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #new' do
    it 'creates new salary' do
      sign_in create(:user)
      expect{ get :new }.to change(Salary, :count).by(1)
    end

    it 'moved if not authenticated' do
      get :new
      expect(response).to have_http_status(302)
    end
  end

  describe 'DELETE #destroy' do
    before do
      @user = create(:user)
      @user2 = create(:user, email: 'test2@test.test')
      @salary = @user.salaries.create
    end

    it 'delete the salary' do
      sign_in @user
      expect{ delete :destroy, id: @salary }.to change(Salary, :count).by(-1)
    end

    it 'not delete the salary if other user' do
      sign_in @user2
      expect{ delete :destroy, id: @salary }.to change(Salary, :count).by(0)
    end

    it 'moved if not authenticated' do
      delete :new, id: @salary
      expect(response).to have_http_status(302)
    end
  end
end
