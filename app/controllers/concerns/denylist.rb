module Denylist
  extend ActiveSupport::Concern

  included do
    def self.jwt_revoked?(payload)
      exists?(jti: payload['jti'])
    end

    def self.revoke_jwt(payload)
      find_or_create_by!(jti: payload['jti'], expired_at: Time.at(payload['exp'].to_i))
    end
  end
end
