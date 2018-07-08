module Harvest
  class ValidationError < ::StandardError
    def initialize(errors)
      @errors = errors
    end

    def to_s
      "The resource is invalid: #{@errors.full_messages}"
    end
  end

  class Base
    include Her::Model
    use_api -> { Harvest.configuration.connection }

    def save
      if valid?
        super
      else
        raise ValidationError.new(self.errors)
      end
    end
  end
end
