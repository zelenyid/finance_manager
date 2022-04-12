# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def not_found
    render json: { error: 'Not Found' }, status: :not_found
  end

  private

  def authorize_request
    header = request.headers['Authorization']
    header = header.split.last if header
    begin
      jwt_payload = JsonWebToken.decode(header)
      @current_user_id = jwt_payload[:id]
    rescue ActiveRecord::RecordNotFound, JWT::DecodeError => e
      render json: { error: e.message }, status: :unauthorized
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
end
