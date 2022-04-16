class RegistrationsController < ApplicationController
  skip_before_action :authorize_request, only: :create

  def create
    user = User.new(sign_up_params)

    if user.save
      token = JsonWebToken.encode(id: user.id)
      render json: token.to_json, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    current_user.destroy
    render json: { status: 'Successfully destroyed' }, status: :ok
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :confirmation_password)
  end
end
