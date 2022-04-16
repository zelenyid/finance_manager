module Errors
  class NilUser < JWT::DecodeError
  end

  class RevokedToken < JWT::DecodeError
  end
end
