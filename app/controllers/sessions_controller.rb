class SessionsController < ApplicationController
  skip_before_action :authorize_request, only: :create

  def create
    user = User.find_by(email: sign_in_params[:email])

    if user&.valid_password?(sign_in_params[:password])
      token = JsonWebToken.encode(id: user.id)
      render json: { token: token, email: user.email }, status: :ok
    else
      render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
    end
  end

  def destroy
    JwtDenylist.revoke_jwt(@jwt_payload)
    render json: { status: 'Successfully logout' }, status: :ok
  end

  private

  def sign_in_params
    params.require(:user).permit(:email, :password)
  end
end
