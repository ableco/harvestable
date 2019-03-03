module Harvestable
  class User < Base
    # Custom Requests
    custom_get :me

    # Scopes
    scope :active, -> { where(is_active: "true") }
  end
end
