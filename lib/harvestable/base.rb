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

    DEFAULT_PER_PAGE = 100
    DEFAULT_FIRST_PAGE = 1

    # Scopes
    scope :page, ->(page) { where(page: page) }
    scope :per_page, ->(per_page) { where(per_page: per_page) }

    # Iterates through each page. Useful for stitching together an array of all
    # records, across every page. For example:
    #
    #   users = User.all.to_a
    #
    # If there are 3 total pages (25 records per page), it would result in
    # these HTTP requests:
    #
    #   GET /v1/users
    #   GET /v1/users?page=2
    #   GET /v1/users?page=3
    #
    #   users.count
    #   # => 75
    #
    # Returns collection of resource objects.
    def self.all
      return to_enum(:all) unless block_given?

      get_page(DEFAULT_FIRST_PAGE) do |result|
        yield result
      end
    end

    def self.get_page(page_number, &block)
      response = per_page(DEFAULT_PER_PAGE).page(page_number)

      response.each do |result|
        yield result
      end

      return if response.count < DEFAULT_PER_PAGE

      get_page(page_number + 1, &block)
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
