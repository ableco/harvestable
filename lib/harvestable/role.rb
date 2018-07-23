module Harvestable
  class Role < Base

    def users
      user_ids.map{  |user_id| Harvestable::User.find(user_id) }
    end
  end
end
