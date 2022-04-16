module JwtSupport
  def get_headers(login, password)
    jwt = get_jwt(login, password)
    {
      Accept: 'application/json',
      'Content-Type': 'application/json',
      Authorization: "Bearer #{jwt}"
    }
  end

  def get_jwt(login, password)
    post '/users/sign_in', params: { user: { email: login, password: password } }
    JSON.parse(response.body, object_class: OpenStruct).token
  end
end

RSpec.configure do |config|
  config.include JwtSupport
end
