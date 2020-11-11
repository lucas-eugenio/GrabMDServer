# frozen_string_literal: true

module Types
  # List of All GraphQL/Querys
  class QueryType < Types::BaseObject
    # Journey
    field :find_journeys, resolver: Resolvers::FindJourneysResolver
    field :my_journeys, resolver: Resolvers::MyJourneysResolver
    # Candidature
    field :my_candidatures, resolver: Resolvers::MyCandidaturesResolver
    field :journey_candidatures, resolver: Resolvers::JourneyCandidaturesResolver
    # Managers
    field :my_managers, resolver: Resolvers::MyManagersResolver
    # Profiles
    field :my_profile, resolver: Resolvers::MyProfileResolver
    field :company_profile, resolver: Resolvers::CompanyProfileResolver
    field :doctor_profile, resolver: Resolvers::DoctorProfileResolver
  end
end
