# frozen_string_literal: true

module Types
  # List of All GraphQL/Querys
  class QueryType < Types::BaseObject
    # Journey
    field :find_journeys, resolver: Resolvers::FindJourneysResolver
    field :my_journeys, resolver: Resolvers::MyJourneysResolver
    # Candidature
    field :my_candidatures, resolver: Resolvers::MyCandidaturesResolver
    # Managers
    field :my_managers, resolver: Resolvers::MyManagersResolver
  end
end
