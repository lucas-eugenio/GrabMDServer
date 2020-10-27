# frozen_string_literal: true

module Types
  # GraphQL/Types/MyJourneysType
  class MyJourneysType < Types::BaseObject
    field :journeys, [Types::JourneyType], null: true
    field :pagination, Types::PaginationType, null: true
    field :errors, String, null: true
  end
end
