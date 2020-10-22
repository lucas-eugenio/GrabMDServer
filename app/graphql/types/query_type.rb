# frozen_string_literal: true

module Types
  # List of All GraphQL/Querys
  class QueryType < Types::BaseObject
    field :find_journeys, resolver: Resolvers::FindJourneysResolver
  end
end
