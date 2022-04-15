class RegistrationsController < Devise::RegistrationsController
  skip_before_action :authorize_request, only: :create
  skip_before_action :authenticate_scope!, only: :destroy

  def create
    user = User.new(sign_up_params)

    if user.save
      token = JsonWebToken.encode(id: user.jti)
      render json: token.to_json, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    current_user.destroy
    render json: { status: 'Successfully destroyed' }, status: :ok
  end
end
