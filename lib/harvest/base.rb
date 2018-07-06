module Harvest
  class Base
    include Her::Model
    use_api -> { Harvest.configuration.connection }
  end
end
