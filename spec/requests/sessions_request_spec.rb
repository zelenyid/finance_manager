require 'rails_helper'

RSpec.describe 'Session', type: :request do
  let!(:user) { create(:user) }

  describe 'POST #create' do
    it 'response is successful' do
      post '/users/sign_in', params: { user: { email: user.email, password: user.password } }

      expect(response).to be_successful
    end
  end

  describe 'DELETE #destroy' do
    it 'response is successful' do
      headers = get_headers(user.email, user.password)
      delete '/users/sign_out', headers: headers

      expect(response).to be_successful
    end
  end
end
