# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authorize_request

  def not_found
    render json: { error: 'Not Found' }, status: :not_found
  end

  private

  def authorize_request
    header = request.headers['Authorization']
    header = header.split.last if header
    begin
      @jwt_payload = JsonWebToken.decode(header)
      @current_user_id = @jwt_payload[:id]
      check_valid_user(@jwt_payload, current_user)
    rescue ActiveRecord::RecordNotFound, JWT::DecodeError
      render json: { error: 'Not authorized' }, status: :unauthorized
    rescue Errors::RevokedToken
      render json: { error: 'Token is revoked' }, status: :unauthorized
    rescue Errors::NilUser
      render json: { error: 'User not found' }, status: :unauthorized
    end
  end

  def authenticate_user!(_options = {})
    head :unauthorized unless signed_in?
  end

  def current_user
    @current_user ||= super || User.find(@current_user_id)
  end

  def signed_in?
    @current_user_id.present?
  end

  def check_valid_user(payload, user)
    raise Errors::NilUser, 'nil user' unless user
    raise Errors::RevokedToken, 'revoked token' if JwtDenylist.jwt_revoked?(payload)
  end
end
