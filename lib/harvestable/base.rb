module Harvestable
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
    use_api -> { Harvestable.configuration.connection }

    def self.page(page)
      where.page(page)
    end

    def self.per_page(per_page)
      where.per_page(per_page)
    end

    def save
      if valid?
        super
      else
        raise ValidationError.new(self.errors)
      end
    end

    def update(attributes)
      assign_attributes(attributes)
      save
    end
  end
end
