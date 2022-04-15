class JsonWebToken
  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s
  ALGORITHM = "HS256"

  def self.encode(payload, exp = 24.hours)
    now = Time.now.to_i
    payload[:iat] ||= now
    payload[:exp] ||= (now + exp).to_i
    payload[:jti] ||= SecureRandom.uuid
    JWT.encode payload, SECRET_KEY
  end

  def self.decode(token)
    decoded = JWT.decode(token,
                         SECRET_KEY,
                         true,
                         algorithm: ALGORITHM,
                         verify_jti: true)[0]
    HashWithIndifferentAccess.new decoded
  end
end
