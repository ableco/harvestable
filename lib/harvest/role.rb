module Harvest
  class Role < Base

    def users
      user_ids.map{  |user_id| Harvest::User.find(user_id) }
    end
  end
end
