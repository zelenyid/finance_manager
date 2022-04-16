require 'rails_helper'

RSpec.describe 'Pings', type: :request do
  let!(:user) { create(:user) }

  it 'Returns a status of 401 if not logged in' do
    get '/ping'

    expect(response).to have_http_status(:unauthorized)
  end

  it 'Returns a status of 200 if logged in' do
    headers = get_headers(user.email, user.password)
    get '/ping', headers: headers

    expect(response).to have_http_status(:ok)
  end
end
