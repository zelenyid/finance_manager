require 'rails_helper'

RSpec.describe 'Registration', type: :request do
  let(:valid_user_params) do
    {
      email: Faker::Internet.email,
      password: 'secret_password',
      password_confirmation: 'secret_password'
    }
  end

  describe 'POST #create' do
    it 'response is successful' do
      post '/users', params: { user: valid_user_params }

      expect(response).to be_successful
    end
  end

  describe 'DELETE #destroy' do
    let!(:user) { create(:user) }

    it 'response is successful' do
      headers = get_headers(user.email, user.password)
      delete '/users', headers: headers

      expect(response).to be_successful
    end
  end
end
