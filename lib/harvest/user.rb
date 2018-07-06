module Harvest
  class User < Base
    scope :active, -> { where(is_active: "true") }

    custom_get :me
  end
end
