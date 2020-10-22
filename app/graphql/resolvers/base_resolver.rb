# frozen_string_literal: true

module Resolvers
  # GraphQL/Resolvers/BaseResolver
  class BaseResolver < GraphQL::Schema::Resolver
    private

    def get_pagination(page, total, per)
      page_count = total / per + ((total % per).positive? ? 1 : 0)
      { page: page || 1, page_count: page_count }
    end

    def filter_page(records, page, per)
      records.limit(per).offset(per * (page - 1))
    end
  end
end
