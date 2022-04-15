class JwtDenylist < ApplicationRecord
  include Denylist

  self.table_name = 'jwt_denylist'
end
