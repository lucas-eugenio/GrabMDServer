# frozen_string_literal: true

module Types
  # GraphQL/Types/PaginationType
  class PaginationType < Types::BaseObject
    field :page, Integer, null: false
    field :page_count, Integer, null: false
  end
end
