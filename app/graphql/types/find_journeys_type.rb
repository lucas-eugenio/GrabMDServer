# frozen_string_literal: true

module Types
  # GraphQL/Types/FindJourneysType
  class FindJourneysType < Types::BaseObject
    field :journeys, [Types::JourneyType], null: true
    field :pagination, Types::PaginationType, null: true
  end
end
