class SessionsController < Devise::SessionsController
  skip_before_action :authorize_request, only: :create
  skip_before_action :verify_signed_out_user

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
    render json: { status: "Successfully logout" }, status: :ok
  end
end
